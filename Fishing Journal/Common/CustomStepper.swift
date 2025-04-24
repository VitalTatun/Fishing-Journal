//
//  CustomStepper.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct CustomStepper: View {
    
    @Binding var number: Int
    @Binding var fishList: [Fish]
    @Binding var fish: Fish
    
    let maxNumber = 20
        
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Button(action: {
                deleteFish(fish: fish)
            }, label: {
                Image(systemName: number <= 1 ? "trash" : "minus")
                    .foregroundStyle(number <= 1 ? .red : .primaryDeepBlue)
                    .font(.body)
                    .tint(.primaryDeepBlue)
            })
            .contentTransition(.symbolEffect(.replace.offUp))
            .frame(width: 28, height: 28, alignment: .center)
            .buttonStyle(.borderless)
            .buttonBorderShape(.circle)
            .contentShape(Circle())
            
            Text("\(number)")
                .frame(width: 46, height: 34, alignment: .center)
                .font(.body)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .contentTransition(.numericText(value: Double(number)))
                .animation(.snappy, value: number)
                .foregroundStyle(.primaryDeepBlue)
                .background(.lightBlue)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            Button {
                increment()
            } label: {
                Image(systemName: "plus")
                    .font(.body)
                    .tint(.primaryDeepBlue)
            }
            .frame(width: 28, height: 28, alignment: .center)
            .buttonStyle(.borderless)
            .buttonBorderShape(.circle)
            .disabled(number == maxNumber)
        }
    }
    
    private func decrease() {
        guard number >= 0 else { return }
        number -= 1
    }
    
    private func increment() {
        guard number >= maxNumber else { return number += 1 }
        number = maxNumber
    }
    
    private func deleteFish(fish: Fish) {
        guard number <= 1 else { return decrease() }
        withAnimation(.bouncy(duration: 0.3,extraBounce: 0.1)) {
            if let index = fishList.firstIndex(where: { $0.id == fish.id }) {
                fishList.remove(at: index)
            }
        }
    }
}
#Preview(body: {
    FishEditView(fish: .constant(Fishing.emptyFishing.fish))
})
