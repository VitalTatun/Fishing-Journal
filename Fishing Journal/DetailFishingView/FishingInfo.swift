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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FishingInfoRow(name: "Fishing Method", element: fishing.fishingMethod.nameRussian)
                Divider()
            FishingInfoRow(name: "Date", element: dateFormatter.string(from: fishing.fishingTime))
                Divider()
            FishingInfoRow(name: "Time", element: timeFormatter.string(from: fishing.fishingTime))
                Divider()
            FishingInfoRow(name: "Bait", element: fishing.bait.nameRussian)
                Divider()
            FishingInfoRow(name: "Weight", element: fishing.weight > 0 ? String(format: "%.1f", fishing.weight) + " кг." : "Не указан")
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(lineWidth: 1)
                .foregroundColor(.black.opacity(0.18))
        }
    }
}

#Preview {
    FishingInfo(fishing: Fishing.example)
}
