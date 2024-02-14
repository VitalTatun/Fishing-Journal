//
//  EditFish.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct EditFish: View {
    
    @Binding var fishing: Fishing
    @Binding var isFishListShowed: Bool
    
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
                    isFishListShowed = true
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
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Text("\(fish.count)")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(.white)
                                    .foregroundStyle(.primaryDeepBlue)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            .frame(height: 36)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 3))
                            .background(.primaryDeepBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
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
    EditFish(fishing: .constant(Fishing.example), isFishListShowed: .constant(false))
}
