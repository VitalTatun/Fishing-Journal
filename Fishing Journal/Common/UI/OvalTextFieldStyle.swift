//
//  OvalTextFieldStyle.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    let strokeColor = Color(red: 207/255, green: 214/255, blue: 236/255)
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .font(.body)
        .padding(10)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(strokeColor)
        }
    }
}
