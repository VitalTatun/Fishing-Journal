//
//  EF_UserFishView.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 23.04.25.
//

import SwiftUI

struct EF_UserFishView: View {
    var userFishCollection: [Fish]
    var selectedFishNames: [String] = []
    var spacing: CGFloat = 4
    
    var didChangeSelection: (Fish) -> ()
    var body: some View {
        VStack(alignment:.leading, spacing: 4) {
            Text("Рыба, которую вы уже указывали в отчетах")
                .font(.footnote)
                .foregroundStyle(.secondary)
            CustomFishTagLayout(spacing: spacing) {
                ForEach(userFishCollection, id: \.name) { fishTag in
                    let isSelected = selectedFishNames.contains(fishTag.name)
                    ChipView(fishTag.name, isSelected: isSelected)
                        .onTapGesture {
                            if !isSelected {
                                didChangeSelection(fishTag)
                            }
                        }
                        .opacity(isSelected ? 0.5 : 1.0)
                        .disabled(isSelected)
                }
            }
            .animation(nil, value: selectedFishNames)
        }
    }
    @ViewBuilder
    func ChipView(_ fish: String, isSelected: Bool) -> some View {
        HStack(spacing: 4) {
            Text(fish)
                .fontDesign(.rounded)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(isSelected ? .gray : .primaryDeepBlue)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? Color.gray.opacity(0.2) : Color(red: 238/255, green: 241/255, blue: 248/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
