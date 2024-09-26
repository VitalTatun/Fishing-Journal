//
//  Fish.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

struct Fish: Equatable, Hashable {
    let id = UUID()
    var name: String
    var count: Int
}
