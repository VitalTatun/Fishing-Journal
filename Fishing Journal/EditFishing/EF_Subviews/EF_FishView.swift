//
//  EF_FishView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 7.03.24.
//

import SwiftUI

import SwiftUI

struct EF_FishView: View {
    
    @Binding var fishing: Fishing
    @Binding var showFishView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Улов")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Text("Отредактируйте список пойманной рыбы")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                // Edit Caught Fish Button
                Button {
                    showFishView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryDeepBlue)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 5) {
                    FishItem(fishing: $fishing)
                }
            }
            
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_FishView(fishing: .constant(Fishing.example), showFishView: .constant(false))
}
