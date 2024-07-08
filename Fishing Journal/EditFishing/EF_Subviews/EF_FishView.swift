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
                CircleButton(icon: "plus") {
                    showFishView = true
                    
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
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 0.18))
        }
    }
}

#Preview {
    EF_FishView(fish: .constant(Fishing.example.fish), showFishView: .constant(false))
}

#Preview("Empty Fish list") {
    EF_FishView(fish: .constant(Fishing.emptyFishing.fish), showFishView: .constant(false))
}
