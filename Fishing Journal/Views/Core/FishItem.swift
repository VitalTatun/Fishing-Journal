//
//  FishItem.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 7.03.24.
//

import SwiftUI

struct FishItem: View {
    
    let fishName: String
    let fishCount: Int
    
    var body: some View {
        HStack {
            Text(fishName)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.primaryDeepBlue)
            Text("\(fishCount) шт.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.primaryDeepBlue)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(Color(red: 182/255, green: 192/255, blue: 229/255))
        }
    }
}

#Preview {
    FishItem(fishName: Fishing.example.fish[0].name, fishCount: Fishing.example.fish.count)
}
