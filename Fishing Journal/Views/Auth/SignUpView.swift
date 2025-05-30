//
//  SignUpView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(AuthService.self) var authService
    @State private var viewModel: AuthenticationViewModel
    
    @State private var showMainView = false
    @State private var isPasswordVisible = false
    
    init(viewModel: AuthenticationViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 5) {
                Group {
                    Text("Sign Up to add your fishing logs")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                        .padding(.bottom, 10)
                    AuthTextField(text: $viewModel.name,
                                  title: "Name",
                                  placeholder: "Enter your name")
                    AuthTextField(text: $viewModel.email,
                                  title: "Email",
                                  placeholder: "name@example.com")
                    AuthSecuredTextField(text: $viewModel.password,
                                         isPasswordVisible: $isPasswordVisible,
                                         title: "Password",
                                         placeholder: "Enter your password")
                }
                Button {
                    Task {
                        await viewModel.signUp()
                    }
                } label: {
                    Text("Sign Up")
                        .font(.system(.body, design: .default, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 50, idealHeight: 56)
                }
                .padding(.top, 30)
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}


