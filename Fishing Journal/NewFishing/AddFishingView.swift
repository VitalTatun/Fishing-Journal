//
//  AddFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 23.03.24.
//

import SwiftUI

struct AddFishingView: View {
    
    @Binding var showAddFishingView: Bool
    @State private var newFishing = Fishing.emptyFishing
    
    var body: some View {
        NavigationStack {
            EditFishingView(fishing: $newFishing, showEditView: $showAddFishingView)
        }
    }
    
    
}

#Preview {
    AddFishingView(showAddFishingView: .constant(false))
}
