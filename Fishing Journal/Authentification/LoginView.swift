//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authService: AuthService
    @State private var viewModel: LoginViewModel
    
    @State private var showMainView = false
    
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var isPasswordVisible = false
    
    init(authService: AuthService) {
        _viewModel = State(wrappedValue: LoginViewModel(authService: authService))
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
                    
                    Button(action: {
                        //TODO: Add Forget password functionality
                    }, label: {
                        Text("Forget password?")
                    })
                    
                    Button(action: {
                        Task {
                            await viewModel.signIn()
                        }
                    }, label: {
                        Text("Login")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    })
                    .padding(.top, 30)
                    //                    .disabled(!Validator.validateEmail(email))
                    .tint(.primaryDeepBlue)
                    .buttonStyle(.borderedProminent)
                    
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .padding()
            }
        }
    }
    
}

