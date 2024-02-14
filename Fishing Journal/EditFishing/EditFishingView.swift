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
    
    @Environment(\.dismiss) var dismiss
        
    @State private var isFishListShowed = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                EditFishingViewHeader(fishing: $fishing)
                EditFishingViewImages(fishing: $fishing)
            }
            .padding(10)
        }
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example))
        
}
