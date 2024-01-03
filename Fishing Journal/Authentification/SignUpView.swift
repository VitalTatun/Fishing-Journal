//
//  SignUpView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Sign Up to add your fishing logs")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Divider()
                InputView(text: $name,
                          title: "Name",
                          placeholder: "Enter your name")
                InputView(text: $email,
                          title: "Email",
                          placeholder: "name@example.com")
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                Spacer()
                NavigationLink {
                    MainView()
                        .environmentObject(FishingData())
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Sign Up")
                        .font(.system(.body, design: .default, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SignUpView()
}
