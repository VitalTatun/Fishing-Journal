//
//  InputView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    
    let title: String
    let placeholder: String
    var isSecureField = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(OvalTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(OvalTextFieldStyle())
            }
        }
    }
}

#Preview {
    InputView(text: .constant("John"), title: "Name", placeholder: "Name")
}
