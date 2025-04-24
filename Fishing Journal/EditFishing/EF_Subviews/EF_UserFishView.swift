//
//  EF_UserFishView.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 23.04.25.
//

import SwiftUI

struct EF_UserFishView: View {
    var userFishCollection: [Fish]
    var spacing: CGFloat = 4
    var animation: Animation = .easeIn(duration: 0.2)
    
    var didChangeSelection: (Fish) -> ()
    var body: some View {
        VStack(alignment:.leading, spacing: 4) {
            Text("Рыба, которую вы уже указывали в отчетах")
                .font(.footnote)
                .foregroundStyle(.secondary)
            CustomFishTagLayout(spacing: spacing) {
                ForEach(userFishCollection, id: \.name) { fishTag in
                    Button {
                        didChangeSelection(fishTag)
                    } label: {
                        ChipView(fishTag.name)
                    }
                }
            }
        }
    }
    @ViewBuilder
    func ChipView(_ fish: String) -> some View {
        HStack(spacing: 4) {
                Text(fish)
                    .fontDesign(.rounded)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primaryDeepBlue)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color(red: 238/255, green: 241/255, blue: 248/255))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

