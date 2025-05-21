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
    
    @State private var viewModel = EditFishingViewModel(fishing: Fishing.emptyFishing)
    
    var body: some View {
        NavigationStack {
            EditFishingView(viewModel: viewModel, showEditView: $showAddFishingView)
        }
    }
}

#Preview {
    AddFishingView(showAddFishingView: .constant(false))
}
