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
        photo: ["6", "7", "8"],
        fishingTime: .now,
        fish: [.init(name: "Карась", count: 2)],
        fishingMethod: .bobber,
        bait: .worm,
        comment: "Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках. Когда рыба стала плотно на точку и ловилась на каждом забросе, я просто ждал когда закончится корм. Фидербай как всегда рулит.",
        user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com")
    )
    
    static let emptyFishing = Fishing(
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
        user: User(
            image: "userExample",
            name: "",
            email: ""))
}
