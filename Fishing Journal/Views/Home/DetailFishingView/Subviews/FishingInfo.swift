//
//  FishingInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI

struct FishingInfo: View {
    
    let fishing: Fishing
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    var fishingDateAndTime: String {
        let time = timeFormatter.string(from: fishing.fishingTime)
        let date = dateFormatter.string(from: fishing.fishingTime)
        return String("\(date)  •  \(time)")
    }
    private var fishingFromTheShore: String {
        guard fishing.fishingFromTheShore else { return "Нет"}
        return "Да"
    }
    private var fishWeight: String {
        return fishing.weight > 0 ? String(format: "%.1f", fishing.weight) + " кг." : "Не указан"
    }
    let shadowColor = Color(white: 0, opacity: 0.05)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FishingInfoRow(name: "Способ ловли", element: fishing.fishingMethod.nameRussian)
            Divider()
            FishingInfoRow(name: "Дата и время", element: fishingDateAndTime)
            Divider()
            FishingInfoRow(name: "Ловля с берега", element: fishingFromTheShore)
            Divider()
            FishingInfoRow(name: "Вес", element: fishWeight)
        }
        
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: shadowColor, radius: 6, x: 0, y: 2)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(.black.opacity(0.18))
        }
    }
}

#Preview {
    FishingInfo(fishing: Fishing.example)
}
