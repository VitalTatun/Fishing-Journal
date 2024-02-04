//
//  TabBarModel.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import Foundation

enum TabBar {
    case home
    case map
    case feed
    case settings
    
    var description: String {
        switch self {
        case .home:
            return "Главная"
        case .map:
            return "Карта"
        case .feed:
            return "Лента"
        case .settings:
            return "Настройки"
        }
    }
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .map:
            return "map"
        case .feed:
            return "lineweight"
        case .settings:
            return "person"
        }
    }
}
