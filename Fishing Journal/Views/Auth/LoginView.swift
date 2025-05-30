//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var viewModel: AuthenticationViewModel
    @Environment(AuthService.self) var authService
    
    @State private var showMainView = false
    
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var isPasswordVisible = false
    
    init(authService: AuthService) {
        _viewModel = State(wrappedValue: AuthenticationViewModel(authService: authService))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Enter your email and password to use your profile ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                        .padding(.bottom, 10)
                    AuthTextField(text: $viewModel.email,
                                  title: "Email",
                                  placeholder: "name@example.com")
                    AuthSecuredTextField(text: $viewModel.password,
                                         isPasswordVisible: $isPasswordVisible,
                                         title: "Password",
                                         placeholder: "Enter your password")
                    Button("Войти") {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                    .tint(.primaryDeepBlue)
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        //TODO: Add Forget password functionality
                    }, label: {
                        Text("Forget password?")
                    })
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .padding()
            }
        }
    }
    
}

