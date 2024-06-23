//
//  SignUpView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = LoginViewModel()

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var showMainView = false
    @State private var isPasswordVisible = false
        
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("Sign Up to add your fishing logs")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Divider()
                            .padding(.bottom, 10)
                        AuthTextField(text: $name,
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
                            try await viewModel.signUp()
                        }
                    } label: {
                        Text("Sign Up")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 50, idealHeight: 56)
                    }
                    .padding(.top, 30)
                    .tint(.primaryDeepBlue)
                    .buttonStyle(.borderedProminent)
//                    .disabled(password.isEmpty)
                    .navigationDestination(isPresented: $showMainView) {
                        MainView()
                            .environmentObject(FishingData())
                            .navigationBarBackButtonHidden()
                    }
                }
            }
            .padding()
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    SignUpView()
}
