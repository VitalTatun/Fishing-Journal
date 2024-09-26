//
//  FishCaught.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI

struct FishCaught: View {
    
  let fish: [Fish]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                FishItem(fish: fish)
            }
        }
    }
}

#Preview {
    FishCaught(fish: Fishing.example.fish)
}
