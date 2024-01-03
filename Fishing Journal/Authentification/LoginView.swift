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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Enter your email and password to use your profile ")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Divider()
                InputView(text: $email,
                          title: "Email",
                          placeholder: "name@example.com")
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                Spacer()
                NavigationLink {
                    MainView()
                        .environmentObject(FishingData())
                        .navigationBarBackButtonHidden()
                } label: {
                        Text("Login")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.large)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}

