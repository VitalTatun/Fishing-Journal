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
                EF_Section(title: "Улов", secondary: "Отредактируйте список пойманной рыбы")
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
