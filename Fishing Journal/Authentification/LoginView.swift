//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showMainView = false
    
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Enter your email and password to use your profile ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                        .padding(.bottom, 10)
                    AuthTextField(text: $email,
                              title: "Email",
                              placeholder: "name@example.com")
                    AuthSecuredTextField(text: $password,
                                     isPasswordVisible: $isPasswordVisible,
                                     title: "Password",
                                     placeholder: "Enter your password")
                    
                    Button(action: {
                        //TODO: Add Forget password functionality
                    }, label: {
                        Text("Forget password?")
                    })
                    
                    Button(action: {
                        showMainView = true
                    }, label: {
                        Text("Login")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    })
                    .frame(width: .infinity, height: 56, alignment: .center)
                    .padding(.top, 30)
                    .disabled(!Validator.validateEmail(email))
                    .navigationDestination(isPresented: $showMainView) {
                        MainView()
                            .environmentObject(FishingData())
                            .navigationBarBackButtonHidden()
                    }
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

#Preview {
    LoginView()
}

