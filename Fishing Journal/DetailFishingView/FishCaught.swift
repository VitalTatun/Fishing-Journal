//
//  FishCaught.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI

struct FishCaught: View {
    let fishing: Fishing

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(fishing.fish, id: \.id) { fish in
                    HStack {
                        Text(fish.name)
                            .font(.body)
                            .lineLimit(1)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Text("\(fish.count)")
                            .font(.callout)
                            .fontWeight(.medium)
                            .padding(5)
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(.white)
                            .foregroundStyle(.primaryDeepBlue)
                            .clipShape(Circle())
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

#Preview {
    FishCaught(fishing: Fishing.example)
}
