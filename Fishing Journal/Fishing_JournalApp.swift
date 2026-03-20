//
//  Fishing_JournalApp.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

@main
struct Fishing_JournalApp: App {
    
    @State private var authService: AuthService
    @StateObject private var fishingData: FishingData

    init() {
        let authService = AuthService()
        _authService = State(initialValue: authService)
        _fishingData = StateObject(wrappedValue: FishingData(authService: authService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService)
                .environmentObject(fishingData)
        }
    }
    
    
}
