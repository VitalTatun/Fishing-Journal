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
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var fishingData = FishingData()
    @StateObject var viewModel = AuthService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(fishingData)
        }
    }
}
