//
//  CircleButton.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 8.07.24.
//

import SwiftUI

struct CircleButton: View {
    
    let icon: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .frame(width: 24, height: 24, alignment: .center)
                .font(.callout)
                .fontWeight(.medium)
        }
        .frame(width: 34, height: 34, alignment: .center)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .controlSize(.small)
        .tint(.primaryDeepBlue)
    }
}


#Preview {
    CircleButton(icon: "plus", action: {
        print("Hello")
    })
}
