//
//  InputView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct AuthTextField: View {
    
    @Binding var text: String
    
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
                TextField(placeholder, text: $text)
                    .textFieldStyle(OvalTextFieldStyle())
                
            Text(errorMessage)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.footnote)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    AuthTextField(text: .constant("John@gmail.com"), title: "Name", placeholder: "Name")
}
