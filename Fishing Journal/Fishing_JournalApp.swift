//
//  Fishing_JournalApp.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

@main
struct Fishing_JournalApp: App {
    
    @StateObject private var fishingData = FishingData()
    
    var body: some Scene {
        WindowGroup {
            Authentication()
//            TabBarView()
//                .environmentObject(fishingData)
        }
    }
}
