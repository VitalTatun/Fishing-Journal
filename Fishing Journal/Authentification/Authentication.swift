//
//  LoginView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct Authentication: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, content: {
                Spacer()
                Text("Fishing Journal")
                    .foregroundStyle(.primaryDeepBlue)
                    .font(.system(.title, design: .default, weight: .bold))
                Spacer()
                NavigationLink {
                    LoginView()
                } label: {
                        Text("Login")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                NavigationLink {
                    SignUpView()
                } label: {
                        Text("Sign Up")
                            .font(.system(.body, design: .default, weight: .medium))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .tint(.primaryDeepBlue)
                .buttonStyle(.bordered)
                .padding(.horizontal)
            })
        }
    }
}

#Preview {
    Authentication()
}
