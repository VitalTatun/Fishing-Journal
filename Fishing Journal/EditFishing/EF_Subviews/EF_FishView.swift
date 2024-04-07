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
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                EF_Section(title: sectionTitle, secondary: sectionSecondary)
                Spacer()
                // Edit Caught Fish Button
                Button {
                    showFishView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryDeepBlue)
                }
            }
            if !fish.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 5) {
                        FishItem(fish: $fish)
                    }
                }
            }
            
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_FishView(fish: .constant(Fishing.example.fish), showFishView: .constant(false))
}

#Preview("Empty Fish list") {
    EF_FishView(fish: .constant(Fishing.emptyFishing.fish), showFishView: .constant(false))
}
