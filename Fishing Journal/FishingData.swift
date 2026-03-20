//
//  FishingData.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

@MainActor
class FishingData: ObservableObject {
    private let service: FishingService

    @Published var isLoading: Bool = true
    @Published var loadErrorMessage: String? = nil
    @Published var mockFishings: [Fishing]

    init(authService: AuthService) {
        self.service = FishingService(client: authService.supabaseClient)
        self.mockFishings = []
        Task {
            await loadFishings()
        }
    }

    convenience init() {
        self.init(authService: AuthService())
    }

    init(previewFishings: [Fishing]) {
        self.service = FishingService(client: AuthService().supabaseClient)
        self.mockFishings = previewFishings
        self.isLoading = false
    }

    static let previewFishings: [Fishing] = [
        Fishing(
            type: .haul,
            name: "На Карася",
            water: Water(waterName: "Минское Море", latitude: 53.95644, longitude: 27.36064),
            photo: [],
            fishingTime: .now,
            weight: 3.2,
            fish: [Fish(name: "Карась", count: 5), Fish(name: "Окунь", count: 1)],
            fishingMethod: .flyFishing, bait: [.maggot],
            comment: "Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках. Когда рыба стала плотно на точку и ловилась на каждом забросе, я просто ждал когда закончится корм. Фидербай как всегда рулит.",
            user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
            shore: true),
        Fishing(
            type: .fishingLog,
            name: "На Карпа c рання и до вечера",
            water: Water(waterName: "Хмелевские пруды.Заславль", latitude: 54.02409, longitude: 27.24313),
            photo: [UIImage(resource: ._6), UIImage(resource: ._7), UIImage(resource: ._9)],
            fishingTime: .now,
            fish: [Fish(name: "Карп", count: 1), Fish(name: "Окунь", count: 5), Fish(name: "Карась", count: 10)],
            fishingMethod:  .feeder, bait: [.bloodworm],
            comment: "Основная глубина в зоне досягаемости моего маркера метр. Лишь в одном месте 1.5. И то это не канавка, а какое то локальное углубление. По хорошему собраться бы и переехать но нет, интересно что получится. Приступили к замесу прикормки. У меня две пачки feeder.by бисквит и пачка сладкий орех. Кормлянул 1.5м.и под тот берег кинул пару кормушек. Там вообще глубина 0.7м. оказалась. Но на дне после корневищ прибрежной травы глеистый участок, а дальше песок. Ловля на 1.5 не получилась сразу же. Там оказалась основная струя течения и гнало мусор. Или срывало кормушку забивая плеть травой, или же забивало саму насадку. Без какой либо надежды ушел на 0.7м. И там уже ловил до конца рыбалки. Очень доставала уклея, которая моментом сбивала мотыля. Но среди уклеек проскакивал подлещ, иногда мелкая плотва. Почти все поклёвки рыбы, как говорят, в лёт. Я так понимаю конкуренция с уклеёй вынуждала подлеща наглеть. Ну по итогу сдался, ловить уклею в темпе с дистанции 54 метра, такое себе занятие🤣. Короче, уклея и жара вынудили досрочно закончить рыбалку и выдвигаться домой. Но при возможности обязательно вернусь на эту реку, тем более по дороге насмотрел пару интересных мест. ",
            user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
            shore: false),
        Fishing(
            type: .haul,
            name: "Крылово",
            water: Water(waterName: "водохранилище Крылово", latitude: 53.96206, longitude: 27.17506),
            photo: [UIImage(resource: ._8), UIImage(resource: ._9)],
            fishingTime: .now,
            weight: 1.2,
            fish: [Fish(name: "Карп", count: 1), Fish(name: "Окунь", count: 5), Fish(name: "Карась", count: 10)],
            fishingMethod: .bobber, bait: [.bloodworm],
            comment: "В планах было два места куда поехать и я как обычно когда не могу решить куда поехать, бросил монетку и выпало как не странно на новое для меня место . Приехал замешал две пачки VABIK PRO речной лещ. Пока прикормка настаивалась я начал поиск точки. Стал примерно на глубине 3 м, дистанция 34м , за корм и в бой . Сразу рыбка отозвалась хорошо, были обрывы поводка и даже сломанный крючок. Клёв продолжался до 10 часов потом как в ванну кидаешь! И я с обеда решил что на сегодня хватит рыбачить . Брали на кусочек червя и одного, два опарыша. По дипам: именно на леща хорошо проявила себя дыня . Поводок 1,5м . На тягал около 8 кг .",
            user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
            shore: true),
        Fishing(
            type: .fishingLog,
            name: "Водохранилище",
            water: Water(waterName: "водохранилище Крылово", latitude: 53.96485, longitude: 27.19577),
            photo: [UIImage(resource: ._7), UIImage(resource: ._9)],
            fishingTime: .now,
            weight: 1.2,
            fish: [Fish(name: "Карп", count: 1), Fish(name: "Окунь", count: 5), Fish(name: "Карась", count: 10)],
            fishingMethod: .spinning,
            bait: [.bloodworm],
            user: User(image: "userExample", name: "Никита Белозерцев", email: "nikita.belozercev@gmail.com"),
            shore: true)
    ]

    func updateFishing(fishing: Fishing) async throws {
        try await service.saveFishing(fishing)

        if let index = mockFishings.firstIndex(where: { $0.id == fishing.id }) {
            mockFishings[index] = fishing.updateComplition()
        } else {
            mockFishings.insert(fishing, at: 0)
        }
    }

    func deleteFishing(_ fishing: Fishing) async throws {
        try await service.deleteFishing(id: fishing.id)
        if let index = mockFishings.firstIndex(where: { $0.id == fishing.id }) {
            mockFishings.remove(at: index)
        }
    }

    func loadFishings() async {
        isLoading = true
        loadErrorMessage = nil
        do {
            let fishings = try await service.fetchFishings()
            mockFishings = fishings
        } catch {
            loadErrorMessage = error.localizedDescription
        }
        isLoading = false
    }

}
