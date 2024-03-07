//
//  FishCaught.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI

struct FishCaught: View {
    
    @Binding var  fishing: Fishing

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                FishItem(fishing: $fishing)
            }
        }
    }
}

#Preview {
    FishCaught(fishing: .constant(Fishing.example))
}
