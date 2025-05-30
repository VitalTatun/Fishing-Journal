//
//  Fishing_JournalApp.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI
import Firebase

@main
struct Fishing_JournalApp: App {
    
    @State private var authService: AuthService

    init() {
        FirebaseApp.configure()
        _authService = State(initialValue: AuthService())

    }
    
    @StateObject private var fishingData = FishingData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService)
                .environmentObject(fishingData)
        }
    }
    
    
}
