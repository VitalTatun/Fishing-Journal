//
//  FishingService.swift
//  Fishing Journal
//
//  Created by Codex on 12.03.26.
//

import Foundation
import Supabase
import UIKit

final class FishingService {
    private let client: SupabaseClient
    private let bucketName = "fishing_photos"

    init(client: SupabaseClient) {
        self.client = client
    }

    convenience init() {
        let config = Self.loadConfig()
        let client = SupabaseClient(
            supabaseURL: config.url,
            supabaseKey: config.anonKey,
            options: .init(
                auth: .init(emitLocalSessionAsInitialSession: true)
            )
        )
        self.init(client: client)
    }

    func saveFishing(_ fishing: Fishing) async throws {
        guard let userId = client.auth.currentUser?.id else {
            throw FishingServiceError.notAuthenticated
        }

        let row = FishingRow(
            id: fishing.id,
            userId: userId,
            isPublic: fishing.isPublic,
            publishedAt: fishing.isPublic ? Date() : nil,
            type: fishing.type.rawValue,
            name: fishing.name,
            waterName: fishing.water.waterName,
            waterLat: fishing.water.latitude,
            waterLng: fishing.water.longitude,
            spotLat: fishing.water.latitude,
            spotLng: fishing.water.longitude,
            fishingTime: fishing.fishingTime,
            weight: fishing.weight,
            fishingMethod: fishing.fishingMethod.rawValue,
            comment: fishing.comment,
            shore: fishing.fishingFromTheShore,
            updatedAt: Date()
        )

        try await client
            .from("fishing")
            .upsert(row, onConflict: "id")
            .execute()

        try await replaceFish(for: fishing)
        try await replaceBaits(for: fishing)
        try await replacePhotos(for: fishing, userId: userId)
    }

    func fetchFishings() async throws -> [Fishing] {
        let response: PostgrestResponse<[FishingFetchRow]> = try await client
            .from("fishing")
            .select()
            .order("fishing_time", ascending: false)
            .execute()

        let rows = response.value
        guard !rows.isEmpty else { return [] }

        let fishingIds = rows.map { $0.id.uuidString }

        let fishRows: [FishingFishRow] = try await fetchRows(
            table: "fishing_fish",
            fishingIds: fishingIds
        )
        let baitRows: [FishingBaitRow] = try await fetchRows(
            table: "fishing_baits",
            fishingIds: fishingIds
        )
        let photoRows: [FishingPhotoRow] = try await fetchRows(
            table: "fishing_photos",
            fishingIds: fishingIds
        )

        let fishById = Dictionary(grouping: fishRows, by: { $0.fishingId })
        let baitById = Dictionary(grouping: baitRows, by: { $0.fishingId })
        let photoById = Dictionary(grouping: photoRows, by: { $0.fishingId })

        let currentUser = client.auth.currentUser
        let fallbackUser = User(
            image: "userExample",
            name: currentUser?.email ?? "User",
            email: currentUser?.email ?? ""
        )

        var result: [Fishing] = []
        result.reserveCapacity(rows.count)

        for row in rows {
            let water = Water(
                waterName: row.waterName ?? "",
                latitude: row.waterLat ?? 0,
                longitude: row.waterLng ?? 0
            )

            let fish = (fishById[row.id] ?? []).map {
                Fish(name: $0.name, count: $0.count)
            }

            let baits = (baitById[row.id] ?? []).compactMap { Bait(rawValue: $0.baitCode) }
            let method = FishingMethod(rawValue: row.fishingMethod ?? FishingMethod.none.rawValue) ?? .none
            let type = FishingType(rawValue: row.type) ?? .fishingLog

            let photos = try await fetchImages(for: photoById[row.id] ?? [])

            let fishing = Fishing(
                id: row.id,
                type: type,
                name: row.name,
                water: water,
                photo: photos,
                fishingTime: row.fishingTime,
                weight: row.weight ?? 0,
                fish: fish,
                fishingMethod: method,
                bait: baits.isEmpty ? [.none] : baits,
                comment: row.comment ?? "",
                user: fallbackUser,
                shore: row.shore ?? true,
                isPublic: row.isPublic
            )
            result.append(fishing)
        }

        return result
    }

    private func fetchRows<T: Decodable>(
        table: String,
        fishingIds: [String]
    ) async throws -> [T] {
        guard !fishingIds.isEmpty else { return [] }
        let response: PostgrestResponse<[T]> = try await client
            .from(table)
            .select()
            .in("fishing_id", values: fishingIds)
            .execute()
        return response.value
    }

    private func fetchImages(for rows: [FishingPhotoRow]) async throws -> [UIImage?] {
        let sortedRows = rows.sorted { $0.sortOrder < $1.sortOrder }
        var images: [UIImage?] = []
        images.reserveCapacity(sortedRows.count)

        for row in sortedRows {
            let image = try await downloadImage(path: row.storagePath)
            images.append(image)
        }
        return images
    }

    private func downloadImage(path: String) async throws -> UIImage? {
        let config = Self.loadConfig()
        let url = config.url.appendingPathComponent("storage/v1/object/\(bucketName)/\(path)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let accessToken = client.auth.currentSession?.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")

        let (data, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        guard (200...299).contains(statusCode) else {
            return nil
        }
        return UIImage(data: data)
    }

    func deleteFishing(id: UUID) async throws {
        let photoRows: [FishingPhotoRow] = try await client
            .from("fishing_photos")
            .select()
            .eq("fishing_id", value: id.uuidString)
            .execute()
            .value

        for row in photoRows {
            try await deleteFromStorage(path: row.storagePath)
        }

        try await client
            .from("fishing")
            .delete()
            .eq("id", value: id.uuidString)
            .execute()
    }

    private func deleteFromStorage(path: String) async throws {
        let config = Self.loadConfig()
        guard let accessToken = client.auth.currentSession?.accessToken else {
            throw FishingServiceError.notAuthenticated
        }

        var request = URLRequest(
            url: config.url.appendingPathComponent("storage/v1/object/\(bucketName)/\(path)")
        )
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")

        let (_, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        if statusCode == 404 {
            return
        }
        guard (200...299).contains(statusCode) else {
            throw FishingServiceError.storageDeleteFailed(statusCode: statusCode)
        }
    }

    private func replaceFish(for fishing: Fishing) async throws {
        try await client
            .from("fishing_fish")
            .delete()
            .eq("fishing_id", value: fishing.id.uuidString)
            .execute()

        let rows = fishing.fish.map { fish in
            FishingFishRow(
                id: UUID(),
                fishingId: fishing.id,
                name: fish.name,
                count: fish.count
            )
        }

        if !rows.isEmpty {
            try await client
                .from("fishing_fish")
                .insert(rows)
                .execute()
        }
    }

    private func replaceBaits(for fishing: Fishing) async throws {
        try await client
            .from("fishing_baits")
            .delete()
            .eq("fishing_id", value: fishing.id.uuidString)
            .execute()

        let rows = fishing.bait
            .filter { $0 != .none }
            .map { bait in
                FishingBaitRow(
                    fishingId: fishing.id,
                    baitCode: bait.rawValue
                )
            }

        if !rows.isEmpty {
            try await client
                .from("fishing_baits")
                .insert(rows)
                .execute()
        }
    }

    private func replacePhotos(for fishing: Fishing, userId: UUID) async throws {
        try await client
            .from("fishing_photos")
            .delete()
            .eq("fishing_id", value: fishing.id.uuidString)
            .execute()

        let images = fishing.photo.compactMap { $0 }
        guard !images.isEmpty else { return }

        var photoRows: [FishingPhotoRow] = []

        for (index, image) in images.enumerated() {
            guard let data = image.jpegData(compressionQuality: 0.85) else { continue }
            let fileName = "\(UUID().uuidString.lowercased()).jpg"
            let path = "\(userId.uuidString.lowercased())/\(fishing.id.uuidString.lowercased())/\(fileName)"

            try await uploadViaRest(
                path: path,
                data: data,
                contentType: "image/jpeg"
            )

            photoRows.append(
                FishingPhotoRow(
                    id: UUID(),
                    fishingId: fishing.id,
                    storagePath: path,
                    sortOrder: index
                )
            )
        }

        if !photoRows.isEmpty {
            try await client
                .from("fishing_photos")
                .insert(photoRows)
                .execute()
        }
    }

    private func uploadViaRest(path: String, data: Data, contentType: String) async throws {
        let config = Self.loadConfig()
        guard let accessToken = client.auth.currentSession?.accessToken else {
            throw FishingServiceError.notAuthenticated
        }

        var request = URLRequest(
            url: config.url.appendingPathComponent("storage/v1/object/\(bucketName)/\(path)")
        )
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue(config.anonKey, forHTTPHeaderField: "apikey")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.upload(for: request, from: data)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        guard (200...299).contains(statusCode) else {
            throw FishingServiceError.storageUploadFailed(statusCode: statusCode)
        }
    }

    private static func loadConfig() -> SupabaseConfig {
        if
            let path = Bundle.main.path(forResource: "SupabaseConfig", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
            let urlString = dictionary["url"] as? String,
            let anonKey = dictionary["anonKey"] as? String,
            let url = URL(string: urlString),
            !anonKey.isEmpty
        {
            return SupabaseConfig(url: url, anonKey: anonKey)
        }

        if
            let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
            let anonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String,
            let url = URL(string: urlString),
            !anonKey.isEmpty
        {
            return SupabaseConfig(url: url, anonKey: anonKey)
        }

        fatalError("Missing Supabase config. Add SupabaseConfig.plist with keys 'url' and 'anonKey', or set SUPABASE_URL/SUPABASE_ANON_KEY in Info.plist.")
    }
}

private struct SupabaseConfig {
    let url: URL
    let anonKey: String
}

private struct FishingRow: Codable {
    let id: UUID
    let userId: UUID
    let isPublic: Bool
    let publishedAt: Date?
    let type: String
    let name: String
    let waterName: String
    let waterLat: Double
    let waterLng: Double
    let spotLat: Double
    let spotLng: Double
    let fishingTime: Date
    let weight: Double
    let fishingMethod: String
    let comment: String
    let shore: Bool
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case isPublic = "is_public"
        case publishedAt = "published_at"
        case type
        case name
        case waterName = "water_name"
        case waterLat = "water_lat"
        case waterLng = "water_lng"
        case spotLat = "spot_lat"
        case spotLng = "spot_lng"
        case fishingTime = "fishing_time"
        case weight
        case fishingMethod = "fishing_method"
        case comment
        case shore
        case updatedAt = "updated_at"
    }
}

private struct FishingFetchRow: Codable {
    let id: UUID
    let userId: UUID
    let isPublic: Bool
    let publishedAt: Date?
    let type: String
    let name: String
    let waterName: String?
    let waterLat: Double?
    let waterLng: Double?
    let spotLat: Double?
    let spotLng: Double?
    let fishingTime: Date
    let weight: Double?
    let fishingMethod: String?
    let comment: String?
    let shore: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case isPublic = "is_public"
        case publishedAt = "published_at"
        case type
        case name
        case waterName = "water_name"
        case waterLat = "water_lat"
        case waterLng = "water_lng"
        case spotLat = "spot_lat"
        case spotLng = "spot_lng"
        case fishingTime = "fishing_time"
        case weight
        case fishingMethod = "fishing_method"
        case comment
        case shore
    }
}

private struct FishingFishRow: Codable {
    let id: UUID
    let fishingId: UUID
    let name: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fishingId = "fishing_id"
        case name
        case count
    }
}

private struct FishingBaitRow: Codable {
    let fishingId: UUID
    let baitCode: String

    enum CodingKeys: String, CodingKey {
        case fishingId = "fishing_id"
        case baitCode = "bait_code"
    }
}

private struct FishingPhotoRow: Codable {
    let id: UUID
    let fishingId: UUID
    let storagePath: String
    let sortOrder: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fishingId = "fishing_id"
        case storagePath = "storage_path"
        case sortOrder = "sort_order"
    }
}

enum FishingServiceError: LocalizedError {
    case notAuthenticated
    case storageUploadFailed(statusCode: Int)
    case storageDeleteFailed(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "Пользователь не авторизован."
        case .storageUploadFailed(let statusCode):
            return "Ошибка загрузки в Storage (код \(statusCode))."
        case .storageDeleteFailed(let statusCode):
            return "Ошибка удаления из Storage (код \(statusCode))."
        }
    }
}
