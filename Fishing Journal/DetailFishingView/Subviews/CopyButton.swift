//
//  CopyButton.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 26.06.24.
//

import SwiftUI

struct CopyButton: View {
    
    @Binding var water: Water
    @State private var pressed: Bool = false
    
    let edgeInsets: EdgeInsets = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10)
    let edgeInsetsButtonPressed: EdgeInsets = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    var body: some View {
        Button {
            copyToPasteboard()
        } label: {
            buttonLabel()
        }
        .disabled(pressed)
    }
    
    @ViewBuilder
    func buttonLabel() -> some View {
        HStack(spacing: 5) {
            Image(systemName: !pressed ? "square.on.square" : "checkmark")
                .contentTransition(.symbolEffect(.replace))
                .font(.callout)
                .foregroundStyle(.primaryDeepBlue)
                .frame(width: 24, height: 24, alignment: .center)
            if pressed {
                Text("Скопировано")
                    .font(.subheadline)
                    .foregroundStyle(.primaryDeepBlue)
            }
        }

        .padding(!pressed ? edgeInsetsButtonPressed : edgeInsets)
        .background(.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(Color(red: 182/255, green: 192/255, blue: 229/255))
        }
    }
    
    func copyToPasteboard() {
        withAnimation(.bouncy) {
            pressed = true
        }
        let pasteboard = UIPasteboard.general
        let coordinates = String(format: "%.5f", water.latitude) + " " + String(format: "%.5f", water.longitude)
        pasteboard.string = coordinates
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            withAnimation(.bouncy) {
                pressed = false
            }
        }
    }
}


#Preview {
    CopyButton(water: .constant(Fishing.example.water))
}

