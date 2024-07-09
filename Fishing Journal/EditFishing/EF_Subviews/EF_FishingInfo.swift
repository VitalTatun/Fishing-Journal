//
//  EF_FishingInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_FishingInfo: View {
    
    @Binding var fishingMethod: FishingMethod
    @Binding var fishingTime: Date
    @Binding var bait: Bait
    @Binding var fishWeight: Double
    @Binding var shore: Bool
    
    var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    let rowHeight: CGFloat = 45
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("Способ ловли")
                    .foregroundColor(.secondary)
                Spacer()
                EF_FishingMethodPicker(selection: $fishingMethod)
            }
            .frame(height: rowHeight)
            Divider()
            HStack(spacing: 0) {
                Text("Наживка")
                    .foregroundColor(.secondary)
                Spacer()
                EF_BaitPicker(selection: $bait)
            }
            .frame(height: rowHeight)
            
            Divider()
            HStack(spacing: 0) {
                DatePicker("Дата и время", selection: $fishingTime, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                    .foregroundColor(.secondary)
            }
            .frame(height: rowHeight)
            Divider()
            Toggle("Ловля с берега", isOn: $shore)
                .foregroundColor(.secondary)
                .frame(height: 50)
            Divider()
            HStack(spacing: 0) {
                Text("Вес")
                    .foregroundColor(.secondary)
                Slider(value: $fishWeight, in: 0...10, step: 0.1)
                    .padding(.horizontal)
                    .tint(.primaryDeepBlue)

                Text(fishWeight as NSNumber, formatter: decimalFormatter)
                    .contentTransition(.interpolate)
                Text("кг.")
                
            }
            .frame(height: 50)
            
        }
        .padding(.horizontal, 10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 0.18))
        }
    }
}

#Preview {
    EF_FishingInfo(
        fishingMethod: .constant(Fishing.example.fishingMethod),
        fishingTime: .constant(Fishing.example.fishingTime),
        bait: .constant(Fishing.example.bait),
        fishWeight: .constant(Fishing.example.weight), shore: .constant(Fishing.example.fishingFromTheShore))
}
