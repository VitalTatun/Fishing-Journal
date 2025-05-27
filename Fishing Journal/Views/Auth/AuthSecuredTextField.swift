//
//  SecuredInputView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.01.24.
//

import SwiftUI

struct AuthSecuredTextField: View {
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    
    let title: String
    let placeholder: String
    var errorMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundStyle(.primaryDeepBlue)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.bottom, 5)
            HStack {
                if isPasswordVisible {
                    TextField(text: $text) {
                        Text(placeholder)
                    }
                } else {
                    SecureField(text: $text) {
                        Text(placeholder)
                    }
                }
                Button(action: {
                        isPasswordVisible.toggle()
                }, label: {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash.fill")
                        .frame(width: 22, height: 22, alignment: .center)
                })
                .disabled(text.isEmpty)
                .tint(.primaryDeepBlue)
            }
            .padding(10)
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(errorMessage)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.footnote)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    AuthSecuredTextField(text: .constant("Password"), isPasswordVisible: .constant(false), title: "Password", placeholder: "Enter your password")
}
