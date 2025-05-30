//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Environment(AuthService.self) var authService
    
    @State private var showSignUpView = false
    @State private var showLoginView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                Text("Fishing Journal")
                    .foregroundStyle(.primaryDeepBlue)
                    .font(.system(.title, design: .default, weight: .bold))
                Spacer()
                
                Button("Войти") {
                    showLoginView = true
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
                
                Button("Регистрация") {
                    showSignUpView = true
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.bordered)

                .navigationDestination(isPresented: $showSignUpView, destination: {
                    let viewModel = AuthenticationViewModel(authService: authService)
                    SignUpView(viewModel: viewModel)
                })
                .navigationDestination(isPresented: $showLoginView, destination: {
                    LoginView(authService: authService)
                })
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environment(AuthService())
}
