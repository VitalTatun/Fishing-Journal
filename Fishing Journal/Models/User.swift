//
//  User.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

struct User: Equatable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id  == rhs.id
    }
    
    let id = UUID()
    let image: String
    let name: String
    let email: String
}

