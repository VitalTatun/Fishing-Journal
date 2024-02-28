//
//  EditFishingViewImages.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct EF_ImagesView: View {
    @Binding var fishing: Fishing
    
    let maxCount = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Фотографии")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Text("Добавьте фотографии")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(0)
                Spacer()
                if !fishing.photo.isEmpty {
                    Text("\(fishing.photo.count)/6")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .foregroundStyle(.primaryDeepBlue)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Button {
                    // TODO: Add images
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryDeepBlue)
                }
            }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(fishing.photo, id: \.self) { item in
                                if let photo = item {
                                    Image(photo)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100,
                                               height: 100,
                                               alignment: .leading)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
            HStack(alignment: .center, spacing: 10) {
                Button {
                        
                    } label: {
                        Text("Заменить")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.primaryDeepBlue)
                            .cornerRadius(5)
                    }
                    .buttonStyle(.plain)

                Button {
                        
                    } label: {
                        Text("Удалить")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(5)
                    }
                    .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    
}

#Preview {
    EF_ImagesView(fishing: .constant(Fishing.example))
}
