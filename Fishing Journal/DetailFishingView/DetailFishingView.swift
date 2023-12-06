//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct DetailFishingView: View {
    
    let fishing: Fishing
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Images(fishing: fishing)
                    Header(fishing: fishing)
                    FishingInfo(fishing: fishing)
                    WaterInfo(fishing: fishing)
                    Comment(fishing: fishing)
                }
                .padding(10)
            }
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingEditView = true
                } label: {
                    Text("Изменить")
                }
            }
        }
    }
}

#Preview {
    DetailFishingView(fishing: Fishing.example)
}
