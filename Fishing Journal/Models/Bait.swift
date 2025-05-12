//
//  Bait.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

enum Bait:String, CaseIterable, Identifiable {
    
    case worm           // Червь
    case maggot         // Опарыш
    case bloodworm      // Мотыль
    case baitfish       // Малек
    case barley         // Перловка
    case corn           // Кукуруза
    case bread          // Хлеб
    case potato         // Картофель
    case semolina       // Манка
    case spoonbait      // Блесна
    case wobbler        // Воблер
    case edibleRubber   // Съедобная резина
    case fly            // Мушка
    case grasshopper    // Кузнечик
    case butterfly      // Мотылек
    case none           // Не выбран
    
    var nameRussian: String {
        switch self {
        case .worm: return "Червь"
        case .maggot: return "Опарыш"
        case .bloodworm: return "Мотыль"
        case .baitfish: return "Малек"
        case .barley: return "Перловка"
        case .corn: return "Кукуруза"
        case .bread: return "Хлеб"
        case .potato: return "Картофель"
        case .semolina: return "Манка"
        case .spoonbait: return "Блесна"
        case .wobbler: return "Воблер"
        case .edibleRubber: return "Съедобная резина"
        case .fly: return "Мушка"
        case .grasshopper: return "Кузнечик"
        case .butterfly: return "Мотылек"
        case .none: return "Не выбран"
        }
    }
    var name: String {
        rawValue
    }
    var id: String {
        name
    }
}
