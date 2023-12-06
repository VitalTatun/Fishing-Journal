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
            return Color.fishingTypeLogBackground
        case .haul:
            return Color.fishingTypeHaulBackground
        }
    }
    var accentColor: Color {
        switch self {
        case .fishingLog:
            return Color.fishingTypeLogAccent
        case .haul:
            return Color.fishingTypeHaulAccent
        }
    }
    var id: String {
        name
    }
}
