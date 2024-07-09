//
//  FishingItem.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct FishingItem: View {
    
    @EnvironmentObject var fishingData: FishingData

    @Binding var fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !fishing.photo.isEmpty {
                if let photo = fishing.photo[0] {
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 157)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(fishing.name)
                    .font(.system(.title3, design: .default, weight: .semibold))
                    .foregroundStyle(.black)
                HStack(alignment: .center, spacing: 2) {
                    Text(fishing.fishingTime, format: Date.FormatStyle().day().month().year())
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(1)
                    Text("•")
                        .foregroundColor(Color.secondary)
                    Text(fishing.water.waterName)
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                        .lineLimit(2)
                    Spacer()
                }
            }
            HStack(alignment: .center, spacing: 5) {
                Text(fishing.type.name)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(fishing.type.accentColor)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(fishing.type.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(fishing.type.accentColor)
                            .opacity(0.2)
                    }
                CapsuleView(text: fishing.fishingMethod.nameRussian)
                CapsuleView(text: fishing.fish[0].name)
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "bookmark.fill")
                        .foregroundStyle(.red)
                    Menu {
                        Button("Добавить в избранное", systemImage: "bookmark") {
                            
                        }
                        Button("Удалить", systemImage: "trash", role: .destructive) {
                            deleteFishing()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(.primaryDeepBlue)
                            .frame(width: 24, height: 24, alignment: .center)

                    }
                }
            }
        }
    }
    private func addToFavorites() {}
    private func deleteFishing() {
        withAnimation() {
            if let index = $fishingData.mockFishings.firstIndex(where: {$0.id == fishing.id}) {
                fishingData.mockFishings.remove(at: index)
            }
        }
    }
    func delete(_ indexSet: IndexSet) {
       withAnimation() {
            fishingData.mockFishings.remove(atOffsets: indexSet)
        }
    }
}

#Preview {
    FishingItem(fishing: .constant(Fishing.example))
}

struct CapsuleView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(Color.primaryDeepBlue)
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(Color.lightBlue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color(red: 182/255, green: 192/255, blue: 229/255))
            }
    }
}
