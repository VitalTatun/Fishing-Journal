//
//  ProfileView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AuthService.self) var authService
    @Environment(\.dismiss) private var dismiss

    let shadowColor = Color(white: 0, opacity: 0.05)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
                HStack(alignment: .center, spacing: 10) {
                    Image(Fishing.example.user.image)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(.circle)
                    VStack(alignment: .leading, spacing: 0){
                        Text(Fishing.example.user.name)
                            .font(.headline)
                        Text(Fishing.example.user.email)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundStyle(.primaryDeepBlue)
                }
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .background(Color(white: 0, opacity: 0.04))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        authService.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                    
                }
            })
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
