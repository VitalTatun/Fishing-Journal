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
    let name: String?
    let nickName: String
    let email: String
    
    init(image: String, name: String?, nickName: String, email: String) {
        self.image = image
        self.name = name
        self.nickName = nickName
        self.email = email
    }
}

