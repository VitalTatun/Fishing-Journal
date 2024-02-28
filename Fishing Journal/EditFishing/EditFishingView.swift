//
//  EditFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 13.02.24.
//

import Foundation
import SwiftUI

struct EditFishingView: View {
    
    @Binding var fishing: Fishing
    @State private var isFishListShowed = false
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    EF_HeaderView(fishing: $fishing)
                    EF_ImagesView(fishing: $fishing)
                    EF_FishView(fishing: $fishing, isFishListShowed: $isFishListShowed)
                    EF_FishingInfo(fishing: $fishing)
                    EF_WaterInfo(fishing: $fishing)
                    EF_CommentView(fishing: $fishing)
                }
                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                .padding(10)
            }
            .navigationTitle(fishing.name)
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isFishListShowed) {
            NavigationStack {
                EF_FishPicker(fishing: $fishing)
            }
        }
        

    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example))
        
}
