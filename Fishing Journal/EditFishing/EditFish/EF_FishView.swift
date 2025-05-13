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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(sectionTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(sectionSecondary)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button(action: {
                    showFishView = true
                }, label: {
                    Image(systemName: fish.isEmpty ? "plus" : "chevron.right")
                        .fontWeight(.medium)
                        .tint(.primary)
                })
            }
            .frame(height: 60)
            .padding(.horizontal, 16)

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
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(.red)
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
