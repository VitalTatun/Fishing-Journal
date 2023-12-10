//
//  User.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import Foundation

class User {
    let id: UUID = UUID()
    let image: String
    let name: String
    let email: String
    
    init(image: String, name: String, email: String) {
        self.image = image
        self.name = name
        self.email = email
    }
}

