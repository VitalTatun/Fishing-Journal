//
//  EditFish.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

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
            HStack(spacing: 10) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 5) {
                        ForEach(fishing.fish, id: \.id) { fish in
                            HStack {
                                Text(fish.name)
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primaryDeepBlue)
                                Text("\(fish.count) шт.")
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
