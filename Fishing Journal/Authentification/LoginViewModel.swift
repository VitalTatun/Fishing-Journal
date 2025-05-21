//
//  LoginViewModel.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.05.24.
//

import Foundation
import Observation

@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    var errorMessage: String?
    var isLoading: Bool = false
    
    func isValid() -> Bool {
        !email.isEmpty && password.count >= 6
    }

    func signIn() async {
        isLoading = true
        do {
            try await AuthService.shared.login(withEmail: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func signUp() async {
        isLoading = true
        do {
            try await AuthService.shared.createUser(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
