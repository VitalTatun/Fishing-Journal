//
//  ProfileView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ProfileAuthenticationView()
                .padding(10)
                .navigationTitle("Профиль")
        }

    }
        
}

#Preview {
    ProfileView()
}
