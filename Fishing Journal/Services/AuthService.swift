//
//  AuthService.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.05.24.
//

import Foundation
import FirebaseAuth
import Foundation
import Observation
import SwiftUI

@Observable
class AuthService {
    
    var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session is \(String(describing: self.userSession))")
    }
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: User \(result.user.uid) logged in")
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
        }
    }
    @MainActor
    func createUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
}

