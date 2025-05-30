//
//  ContentView.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 22.05.25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthService.self) var authService
    
    var body: some View {
        Group {
            if authService.userSession != nil {
                TabBarView()
            } else {
                AuthenticationView() 
            }
        }
    }
}

#Preview {
    ContentView()
}
