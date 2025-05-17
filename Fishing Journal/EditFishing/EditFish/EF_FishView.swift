//
//  EF_FishView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 7.03.24.
//

import SwiftUI

import SwiftUI

struct EF_FishView: View {
    
    @Binding var fish: [Fish]
    @Binding var showFishView: Bool
    
    private let sectionTitle: String = "Улов"
    private let sectionSecondary: String = "Отредактируйте список пойманной рыбы"
    
    private var icon: String {
        return String(fish.isEmpty ? "plus" : "chevron.right")
    }
    private var statusColor: Color {
        return Color(fish.isEmpty ? .red : .green)
    }
    
    var body: some View {
        EF_CardItemContainer {
            EF_SectionHeader(title: sectionTitle, secondary: sectionSecondary, icon: icon) {
                showFishView.toggle()
            }
            if !fish.isEmpty {
                Divider()
                CustomFishTagLayout(spacing: 4) {
                    ForEach(fish, id: \.self) { fish in
                        FishViewItem(fish)
                    }
                }
                .padding(4)
            }
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(statusColor)
                .offset(x: 6, y: 6)
                .frame(width: 6, height: 6)
        }
    }
}

@ViewBuilder
func FishViewItem(_ fish: Fish) -> some View {
    HStack(alignment: .center, spacing: 8) {
        Text(fish.name)
                .fontDesign(.rounded)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.primaryDeepBlue)
        Text("\(fish.count) шт.")
            .fontDesign(.rounded)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.primaryDeepBlue)
    }
    .padding(.horizontal, 12)
    .frame(height: 40)
    .background(Color(red: 238/255, green: 241/255, blue: 248/255))
    .clipShape(RoundedRectangle(cornerRadius: 10))
}

#Preview {
    EF_FishView(fish: .constant(Fishing.example.fish), showFishView: .constant(false))
}

#Preview("Empty Fish list") {
    EF_FishView(fish: .constant(Fishing.emptyFishing.fish), showFishView: .constant(false))
}
