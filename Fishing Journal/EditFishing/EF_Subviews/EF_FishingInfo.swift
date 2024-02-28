//
//  EF_FishingInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_FishingInfo: View {
    
    @Binding var fishing: Fishing
    
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
                EF_FishingMethodPicker(selection: $fishing.fishingMethod)
            }
            Divider()
            HStack(spacing: 0) {
                DatePicker("Дата", selection: $fishing.fishingTime, in: ...Date(), displayedComponents: .date)
                    .foregroundColor(.secondary)
            }
            Divider()
            HStack(spacing: 0) {
                DatePicker("Время", selection: $fishing.fishingTime, in: ...Date(), displayedComponents: .hourAndMinute)
                    .foregroundColor(.secondary)
            }
            Divider()
            HStack(spacing: 0) {
                Text("Наживка")
                    .foregroundColor(.secondary)
                Spacer()
                EF_BaitPicker(selection: $fishing.bait)
            }
            Divider()
            HStack(spacing: 0) {
                Text("Вес")
                    .foregroundColor(.secondary)
                Slider(value: $fishing.weight, in: 0...10, step: 0.1)
                    .padding(.horizontal)
                Text(fishing.weight as NSNumber, formatter: decimalFormatter)
                Text("кг.")
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_FishingInfo(fishing: .constant(Fishing.example))
}
