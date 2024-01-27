//
//  OvalTextFieldStyle.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.01.24.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .font(.body)
        .padding(10)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .shadow(radius: 10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
