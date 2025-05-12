//
//  EF_FishingMethodAndBait.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 4.05.25.
//

import SwiftUI

struct EF_FishingMethodAndBait: View {
    
    @Binding var showFishingMethodAndBait: Bool
    @Binding var fishingMethod: FishingMethod
    @Binding var bait: [Bait]
    
    private let sectionTitle: String = "Способ ловли и наживка"
    private let sectionSecondary: String = "Отредактируйте список наживки"
    
    private var baitDisplayText: String {
        bait.map { $0.nameRussian }.joined(separator: ", ")
    }
    
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
                    showFishingMethodAndBait = true
                }, label: {
                    Image(systemName: "chevron.right")
                        .fontWeight(.medium)
                        .tint(.primary)
                })
            }
            .frame(height: 60)
            .padding(.horizontal, 16)
            Divider()
            EF_LabelRow(title: "Способ ловли", value: fishingMethod.nameRussian)
            Divider()
            EF_LabelRow(title: "Наживка", value: baitDisplayText)
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

struct EF_LabelRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(title)
                .font(.callout)
            Spacer()
            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 11)
    }
}

#Preview {
    EF_FishingMethodAndBait(showFishingMethodAndBait: .constant(false), fishingMethod: .constant(Fishing.example.fishingMethod), bait: .constant(Fishing.example.bait))
}
