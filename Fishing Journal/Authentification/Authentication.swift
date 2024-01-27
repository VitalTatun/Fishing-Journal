//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct Authentication: View {
    
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
                
                Button(action: {
                    showLoginView = true
                }, label: {
                    Text("Login")
                        .font(.system(.body, design: .default, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                })
                .navigationDestination(isPresented: $showLoginView, destination: {
                    LoginView()
                })
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                Button(action: {
                    showSignUpView = true
                }, label: {
                    Text("Sign Up")
                        .font(.system(.body, design: .default, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                })
                .navigationDestination(isPresented: $showSignUpView, destination: {
                    SignUpView()
                })
                .tint(.primaryDeepBlue)
                .buttonStyle(.bordered)
                .padding([.horizontal, .bottom])
            }
        }
    }
}

#Preview {
    Authentication()
}
