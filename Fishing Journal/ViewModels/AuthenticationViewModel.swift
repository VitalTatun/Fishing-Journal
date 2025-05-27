//
//  LoginViewModel.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.05.24.
//

import Foundation
import Observation

@Observable
class AuthenticationViewModel {
    
    private var authService: AuthService
    
    var email: String = ""
    var password: String = ""
    var name = ""
    
    var errorMessage: String?
    var isLoading: Bool = false
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func isValid() -> Bool {
        !email.isEmpty && password.count >= 6
    }
    
    func signIn() async {
        isLoading = true
        do {
            try await authService.login(withEmail: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func signUp() async {
        isLoading = true
        do {
            try await authService.createUser(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
