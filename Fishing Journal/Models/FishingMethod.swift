//
//  FishingMethod.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

enum FishingMethod: String, CaseIterable, Identifiable {
    
    case none
    case bobber
    case spinning
    case feeder
    case flyFishing
    
    var nameRussian: String {
        switch self {
        case .bobber:
            return "Поплавок"
        case .spinning:
            return "Спиннинг"
        case .feeder:
            return "Фидер"
        case .flyFishing:
            return "Нахлыст"
        case .none:
            return "Не выбрано"
        }
    }
    var icon: String {
        switch self {
        case .bobber:
            return "Bobber"
        case .spinning:
            return "Spinning"
        case .feeder:
            return "Feeder"
        case .flyFishing:
            return "Flyfishing"
        case .none:
            return "Fish"
        }
    }
    var id: String {
        rawValue
    }
}
