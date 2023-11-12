//
//  FishingItem.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct FishingItem: View {
    
    let fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let photo = fishing.photo[0] {
                Image(photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 157)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(fishing.name)
                    .font(.system(.title3, design: .default, weight: .semibold))
                    .foregroundStyle(.black)
                HStack(alignment: .center, spacing: 2) {
                    Text(.now, format: Date.FormatStyle().day().month().year())
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(1)
                    Text("•")
                        .foregroundColor(Color.secondary)
                    Text(fishing.water.waterName)
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(1)
                    Spacer()
                }
            }
            HStack(alignment: .center, spacing: 5, content: {
                Text(fishing.type.name)
                    .foregroundStyle(Color(red: 61/255, green: 83/255, blue: 59/255))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color(red: 179/255, green: 219/255, blue: 154/255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color(red: 61/255, green: 83/255, blue: 59/255))
                    }
                Text(fishing.fishingMethod.nameRussian)
                    .foregroundStyle(Color(red: 62/255, green: 84/255, blue: 129/255))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color(red: 238/255, green: 242/255, blue: 255/255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color(red: 62/255, green: 84/255, blue: 129/255))
                    }
                Text(fishing.fish[0].name)
                    .foregroundStyle(Color(red: 62/255, green: 84/255, blue: 129/255))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color(red: 238/255, green: 242/255, blue: 255/255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color(red: 62/255, green: 84/255, blue: 129/255))
                    }
            })
            
        }
    }
}

#Preview {
    FishingItem(fishing: Fishing.example)
}
