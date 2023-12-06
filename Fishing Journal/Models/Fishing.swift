//
//  Fishing.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct Fishing: Identifiable {
    let id: UUID = UUID()
    var type: FishingType
    var name: String
    var water: Water
    var photo: [String?]
    var fishingTime: Date
    var weight: Double = 0
    var fish: [Fish]
    var fishingMethod: FishingMethod
    var bait: Bait
    var comment: String = ""
    let user: User
    
    static let example = Fishing(
        type: .fishingLog,
        name: "На Карася",
        water: Water(waterName: "Минское Море", latitude: 53.95644, longitude: 27.36064),
        photo: ["6"],
        fishingTime: .now,
        fish: [.init(name: "Карась", count: 2)],
        fishingMethod: .bobber,
        bait: .worm,
        user: User(image: "userExample", name: "Никита Белозерцев", nickName: "Lucky", email: "nikita.belozercev@gmail.com"))
}
