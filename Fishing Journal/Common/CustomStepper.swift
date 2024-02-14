//
//  CustomStepper.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct CustomStepper: View {
    
    @Binding var number: Int
    let maxnumber = 20
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(action: {
                decrease()
            }, label: {
                Image(systemName: "minus")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.primaryDeepBlue)
            })
            .disabled(number == 1)
            .buttonStyle(.borderless)
            
            Text("\(number)")
                .frame(width: 50, height: 36, alignment: .center)
                .font(.body)
                .fontWeight(.medium)
//                .background(.secondary)
                .foregroundStyle(.primaryDeepBlue)
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
        if number <= 0 {
            
        }
        else {
            number -= 1
        }
    }
    
    private func increment() {
        if number >= maxnumber {
            number = maxnumber
        }
        else {
            number += 1
        }
    }
    
}

#Preview {
    CustomStepper(number: .constant(10))
}
