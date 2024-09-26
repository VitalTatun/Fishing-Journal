//
//  Water.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

struct Water: Identifiable, Hashable {
    let id = UUID()
    var waterName: String
    let latitude: Double
    let longitude: Double
}
