//
//  EF_FishingInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_FishingInfo: View {
    
    @Binding var fishing: Fishing
    @Binding var fishingMethod: FishingMethod
    @Binding var fishingTime: Date
    @Binding var bait: Bait
    @Binding var fishWeight: Double
    
    var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                Text("Способ ловли")
                    .foregroundColor(.secondary)
                Spacer()
                EF_FishingMethodPicker(selection: $fishingMethod)
            }
            Divider()
            HStack(spacing: 0) {
                Text("Наживка")
                    .foregroundColor(.secondary)
                Spacer()
                EF_BaitPicker(selection: $bait)
            }
            Divider()
            HStack(spacing: 0) {
                DatePicker("Дата", selection: $fishingTime, in: ...Date(), displayedComponents: .date)
                    .foregroundColor(.secondary)
            }
            Divider()
            HStack(spacing: 0) {
                DatePicker("Время", selection: $fishingTime, in: ...Date(), displayedComponents: .hourAndMinute)
                    .foregroundColor(.secondary)
            }
            Divider()
            
            HStack(spacing: 0) {
                Text("Вес")
                    .foregroundColor(.secondary)
                Slider(value: $fishWeight, in: 0...10, step: 0.1)
                    .padding(.horizontal)
                Text(fishWeight as NSNumber, formatter: decimalFormatter)
                Text("кг.")
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_FishingInfo(
        fishing: .constant(Fishing.example),
        fishingMethod: .constant(Fishing.example.fishingMethod),
        fishingTime: .constant(Fishing.example.fishingTime),
        bait: .constant(Fishing.example.bait),
        fishWeight: .constant(Fishing.example.weight))
}
