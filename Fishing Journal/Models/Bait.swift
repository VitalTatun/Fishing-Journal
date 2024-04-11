//
//  Bait.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

enum Bait:String, CaseIterable, Identifiable {
    
    case none
    case bloodworm
    case maggot
    case worm
    case baitfish
    
    var nameRussian: String {
        switch self {
        case .bloodworm:
            return "Мотыль"
        case .maggot:
            return "Опарыш"
        case .worm:
            return "Червь"
        case .baitfish:
            return "Живец"
        case .none:
            return "Не выбрана"
        }
    }
    var name: String {
        rawValue
    }
    var id: String {
        name
    }
}
