//
//  CopyButton.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 26.06.24.
//

import SwiftUI

struct CopyButton: View {
    
    let water: Water
    @State private var isPressed: Bool = false
    
    let edgeInsets: EdgeInsets = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10)
    let edgeInsetsButtonPressed: EdgeInsets = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    var body: some View {
        Button {
            copyToPasteboard()
        } label: {
            buttonLabel()
        }
        .disabled(isPressed)
    }
    
    @ViewBuilder
    func buttonLabel() -> some View {
        HStack(spacing: 5) {
            Image(systemName: !isPressed ? "square.on.square" : "checkmark")
                .contentTransition(.symbolEffect(.replace))
                .font(.callout)
                .foregroundStyle(.white)
                .frame(width: 24, height: 24, alignment: .center)
            if isPressed {
                Text("Скопировано")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
        }
        .padding(!isPressed ? edgeInsetsButtonPressed : edgeInsets)
        .background(.primaryDeepBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func copyToPasteboard() {
        withAnimation(.bouncy) {
            isPressed = true
        }
        let pasteboard = UIPasteboard.general
        let coordinates = String(format: "%.5f", water.latitude) + " " + String(format: "%.5f", water.longitude)
        pasteboard.string = coordinates
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            withAnimation(.bouncy) {
                isPressed = false
            }
        }
    }
}


#Preview {
    CopyButton(water: Fishing.example.water)
}

