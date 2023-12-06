//
//  FishingItem.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct FishingItem: View {
    
    let fishingData: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let photo = fishingData.photo[0] {
                Image(photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 157)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(fishingData.name)
                    .font(.system(.title3, design: .default, weight: .semibold))
                    .foregroundStyle(.black)
                HStack(alignment: .center, spacing: 2) {
                    Text(.now, format: Date.FormatStyle().day().month().year())
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(1)
                    Text("•")
                        .foregroundColor(Color.secondary)
                    Text(fishingData.water.waterName)
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(2)
                    Spacer()
                }
            }
            HStack(alignment: .center, spacing: 5, content: {
                Text(fishingData.type.name)
                    .font(.footnote)
                    .fontWeight(.medium)
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
                Text(fishingData.fishingMethod.nameRussian)
                    .font(.footnote)
                    .fontWeight(.medium)
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
                
                Text(fishingData.fish[0].name)
                    .font(.footnote)
                    .fontWeight(.medium)
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
                Spacer()
                Image(systemName: "bookmark.fill")
                    .foregroundStyle(.red)
            })
        }
    }
}

#Preview {
    FishingItem(fishingData: Fishing.example)
}
