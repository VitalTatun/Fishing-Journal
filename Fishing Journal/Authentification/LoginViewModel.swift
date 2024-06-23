//
//  LoginViewModel.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.05.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
    func signUp() async throws {
        try await AuthService.shared.createUser(email: email, password: password)
    }
}

