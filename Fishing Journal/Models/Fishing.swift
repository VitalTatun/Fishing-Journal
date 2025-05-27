//
//  Fishing.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct Fishing: Identifiable, Hashable {
    
    let id: UUID
    var type: FishingType
    var name: String
    var water: Water
    var photo: [UIImage?]
    var fishingTime: Date
    var weight: Double
    var fish: [Fish]
    var fishingMethod: FishingMethod
    var bait: [Bait]
    var comment: String
    let user: User
    var fishingFromTheShore: Bool
    
    init(
        id: UUID = UUID(),
        type: FishingType,
        name: String,
        water: Water,
        photo: [UIImage?] = [],
        fishingTime: Date,
        weight: Double = 0,
        fish: [Fish],
        fishingMethod: FishingMethod,
        bait: [Bait],
        comment: String = "",
        user: User,
        shore: Bool = true) {
            self.id = id
            self.type = type
            self.name = name
            self.water = water
            self.photo = photo
            self.fishingTime = fishingTime
            self.fish = fish
            self.fishingMethod = fishingMethod
            self.bait = bait
            self.comment = comment
            self.user = user
            self.weight = weight
            self.fishingFromTheShore = shore
        }
    
    func updateComplition() -> Fishing {
        return Fishing(id: id, type: type, name: name, water: water, photo: photo, fishingTime: fishingTime, weight: weight, fish: fish, fishingMethod: fishingMethod, bait: bait, comment: comment, user: user, shore: fishingFromTheShore)
    }
    
    
    static let example = Fishing(
        type: .fishingLog,
        name: "На Карася",
        water: Water(waterName: "Минское Море", latitude: 53.95644, longitude: 27.36064),
        photo: [UIImage(resource: ._6), UIImage(resource: ._7), UIImage(resource: ._8)],
        fishingTime: .now,
        fish: [.init(name: "Карась", count: 2)],
        fishingMethod: .bobber,
        bait: [.worm],
        comment: "Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках. Когда рыба стала плотно на точку и ловилась на каждом забросе, я просто ждал когда закончится корм. Фидербай как всегда рулит.",
        user: User(image: "userExample2", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
        shore: true
    )
    
    static var emptyFishing = Fishing(
        type: .fishingLog,
        name: "",
        water: Water(
            waterName: "",
            latitude: .zero,
            longitude: .zero),
        photo: [],
        fishingTime: .now,
        fish: [],
        fishingMethod: .none,
        bait: [.none],
        user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
        shore: false)
}
