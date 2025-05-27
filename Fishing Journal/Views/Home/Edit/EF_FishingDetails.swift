//
//  EF_FishingDetails.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 2.05.25.
//

import SwiftUI

struct EF_FishingDetails: View {
    
    @State private var publishFishing = true
    @Binding var fishingType: FishingType
    @Binding var fishingTime: Date
    @Binding var shore: Bool
    @Binding var fishWeight: Double



    var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    let rowHeight: CGFloat = 44
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            publishRow()
            Divider()
            fishingDateAndTime(fishingTime: $fishingTime)
            Divider()
            shoreRow(from: $shore)
            Divider()
            weightRow()
        }
        .font(.callout)
        .padding(.horizontal, 10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
    }
    
    
    @ViewBuilder
    func publishRow() -> some View {
        HStack(alignment: .center, spacing: 10) {
            Toggle("Опубликовать", isOn: $publishFishing)
        }
        .frame(height: rowHeight)
    }
    
    @ViewBuilder
    func fishingDateAndTime(fishingTime: Binding<Date>) -> some View {
        HStack(alignment: .center, spacing: 10) {
            DatePicker("Дата и время", selection: fishingTime, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
        }
        .frame(height: rowHeight)
    }
    
    @ViewBuilder
    func shoreRow(from shore: Binding<Bool>) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Toggle("Ловля с берега", isOn: shore)
        }
        .frame(height: rowHeight)
    }
    
    @ViewBuilder
    func weightRow() -> some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Вес")
                .foregroundColor(.primary)
            Slider(value: $fishWeight, in: 0...10, step: 0.1)
                .padding(.horizontal)
                .tint(.primaryDeepBlue)

            Text(fishWeight as NSNumber, formatter: decimalFormatter)
                .contentTransition(.interpolate)
            Text("кг.")
                
        }
        .frame(height: 60)
    }
}

#Preview {
    EF_FishingDetails(
        fishingType: .constant(Fishing.example.type),
        fishingTime: .constant(Fishing.example.fishingTime),
        shore: .constant(Fishing.example.fishingFromTheShore),
        fishWeight: .constant(Fishing.example.weight))
}
