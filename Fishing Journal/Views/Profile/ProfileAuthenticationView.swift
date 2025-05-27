//
//  ProfileAuthenticationView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 15.08.24.
//

import SwiftUI

struct ProfileAuthenticationView: View {
    
    @State private var showAuthenticationView = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Spacer()
            Image(systemName: "person.crop.circle")
                .font(.system(size: 100))
                .foregroundStyle(.primaryDeepBlue)
            VStack(spacing: 10) {
                Text("Войти или зарегистрироваться")
                    .font(.headline)
                Text("Зарегистрируйтесь или войдите в свой аккаунт чтобы воспользоваться всеми возможностями приложения")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack {
               Button {
                  
               } label: {
                   Text("Войти")
                       .font(.body)
                       .fontWeight(.medium)
                       .padding(.horizontal, 8)
                       .frame(maxWidth: .infinity)
                       .cornerRadius(5)
               }
               .controlSize(.large)

               .tint(.primaryDeepBlue)
               .buttonStyle(.borderedProminent)
                NavigationLink {
                    AuthenticationView()
                } label: {
                    Text("Зарегистрироваться")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(5)
                }
                .controlSize(.large)
                .tint(.primaryDeepBlue)
                .buttonStyle(.bordered)
                
           }
        }
    }
}

#Preview {
    ProfileAuthenticationView()
}
