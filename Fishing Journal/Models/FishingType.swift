//
//  FishingType.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation
import SwiftUI

enum FishingType: String, CaseIterable, Identifiable {
    
    case fishingLog
    case haul
    
    var name: String {
        switch self {
        case .fishingLog:
            return "Отчет"
        case .haul:
            return "Трофей"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .fishingLog:
            return Color(red: 179/255, green: 219/255, blue: 154/255)
        case .haul:
            return Color(red: 255/255, green: 215/255, blue: 29/255)
        }
    }
    var id: String {
        name
    }
}
