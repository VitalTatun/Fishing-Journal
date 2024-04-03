//
//  Fishing.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct Fishing: Identifiable {
    
    let id: UUID
    var type: FishingType
    var name: String
    var water: Water
    var photo: [String?]
    var fishingTime: Date
    var weight: Double
    var fish: [Fish]
    var fishingMethod: FishingMethod
    var bait: Bait
    var comment: String
    let user: User
    
    init(id: UUID = UUID(), type: FishingType, name: String, water: Water, photo: [String?], fishingTime: Date, weight: Double = 0, fish: [Fish], fishingMethod: FishingMethod, bait: Bait, comment: String = "", user: User) {
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
    }
    
    func updateComplition() -> Fishing {
        return Fishing(id: id, type: type, name: name, water: water, photo: photo, fishingTime: fishingTime, weight: weight, fish: fish, fishingMethod: fishingMethod, bait: bait, comment: comment, user: user)
    }
    
    
    static let example = Fishing(
        type: .fishingLog,
        name: "На Карася",
        water: Water(waterName: "Минское Море", latitude: 53.95644, longitude: 27.36064),
        photo: ["6", "7", "8"],
        fishingTime: .now,
        fish: [.init(name: "Карась", count: 2)],
        fishingMethod: .bobber,
        bait: .worm,
        comment: "Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках. Когда рыба стала плотно на точку и ловилась на каждом забросе, я просто ждал когда закончится корм. Фидербай как всегда рулит.",
        user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com")
    )
    
    static var emptyFishing = Fishing(
        type: .fishingLog,
        name: "",
        water: Water(
            waterName: "",
            latitude: 53.96485,
            longitude: 27.19577),
        photo: [],
        fishingTime: .now,
        fish: [],
        fishingMethod: .bobber,
        bait: .worm,
        user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"))
}
