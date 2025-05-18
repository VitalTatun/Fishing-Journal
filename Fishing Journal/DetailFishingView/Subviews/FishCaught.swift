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
                CustomFishTagLayout(spacing: 4) {
                    ForEach(fish, id: \.self) { fish in
                        FishViewItem(fish)
                    }
                }
                .padding(4)
    }
}

#Preview {
    FishCaught(fish: Fishing.example.fish)
}
