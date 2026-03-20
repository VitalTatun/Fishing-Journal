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
    @State private var showDeleteAlert = false
    @State private var showDeleteError = false
    @State private var deleteErrorMessage = ""
    @State private var isDeleting = false
    @State private var isFavorite = false
    
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
                if let firstFish = fishing.fish.first {
                    CapsuleView(text: firstFish.name)
                }
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(isFavorite ? .red : .secondary)
                    if isDeleting {
                        ProgressView()
                    } else {
                        Menu {
                            Button(
                                isFavorite ? "Убрать из избранного" : "Добавить в избранное",
                                systemImage: isFavorite ? "bookmark.slash" : "bookmark"
                            ) {
                                isFavorite.toggle()
                            }
                            Button("Удалить", systemImage: "trash", role: .destructive) {
                                showDeleteAlert = true
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.primaryDeepBlue)
                                .frame(width: 24, height: 24, alignment: .center)

                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .alert("Удалить отчет?", isPresented: $showDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                deleteFishing()
            }
        } message: {
            Text("Отчет \"\(fishing.name)\" будет удален без возможности восстановления.")
        }
        .alert("Не удалось удалить", isPresented: $showDeleteError) {
            Button("Ок", role: .cancel) { }
        } message: {
            Text(deleteErrorMessage)
        }
    }
    private func deleteFishing() {
        isDeleting = true
        Task {
            do {
                try await fishingData.deleteFishing(fishing)
            } catch {
                deleteErrorMessage = error.localizedDescription
                showDeleteError = true
            }
            isDeleting = false
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
