//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct DetailFishingView: View {
    
    let fishing: Fishing
    
    var body: some View {
        Text(fishing.name)
    }
}

#Preview {
    DetailFishingView(fishing: Fishing.example)
       
}
