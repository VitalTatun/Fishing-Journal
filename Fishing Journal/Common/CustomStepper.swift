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
    
    let maxnumber = 20
        
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(action: {
                deleteFish(fish: fish)
            }, label: {
                Image(systemName: number <= 1 ? "trash" : "minus")
                    .foregroundStyle(number <= 1 ? .red : .primaryDeepBlue)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.primaryDeepBlue)
            })
            .contentTransition(.symbolEffect(.replace.offUp))
            .buttonStyle(.borderless)
            
            Text("\(number)")
                .frame(width: 46, height: 36, alignment: .center)
                .font(.body)
                .fontWeight(.semibold)
                .contentTransition(.numericText(value: Double(number)))
                .animation(.snappy, value: number)
                .foregroundStyle(.primaryDeepBlue)
                .background(.lightBlue)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            Button(action: {
                increment()
            }, label: {
                Image(systemName: "plus")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.primaryDeepBlue)
            })
            .buttonStyle(.borderless)
        }
    }
    
    private func decrease() {
        guard number >= 0 else { return }
        number -= 1
    }
    
    private func increment() {
        guard number >= maxnumber else { return number += 1 }
        number = maxnumber
    }
    
    private func deleteFish(fish: Fish) {
        guard number <= 1 else { return decrease() }
        withAnimation {
            if let index = fishList.firstIndex(where: { $0.id == fish.id }) {
                fishList.remove(at: index)
            }
        }
    }
}
#Preview(body: {
    FishEditView(fish: .constant(Fishing.emptyFishing.fish))
})
