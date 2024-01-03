//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct DetailFishingView: View {
    
    let fishing: Fishing
    @State private var selectedImage: String?
    
    @State private var isPresentingEditView = false
    @State private var isPresentingPhotoView = false
    
    @State private var isFavorite = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 5) {
                            ForEach(fishing.photo, id: \.self) { item in
                                if let photo = item {
                                    Image(photo)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width - 50,
                                               height: 197,
                                               alignment: .leading)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .onTapGesture {
                                            selectedImage = item
                                            isPresentingPhotoView = true
                                        }
                                }
                            }
                        }
                    })
                    Header(fishing: fishing)
                    FishingInfo(fishing: fishing)
                    WaterInfo(fishing: fishing)
                    Comment(fishing: fishing)
                }
                .padding(10)
            }
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            
            .fullScreenCover(isPresented: $isPresentingPhotoView, content: {
                NavigationStack {
                    PhotoView(fishing: fishing, selectedImage: $selectedImage)
                }
            })
            
        }
//        Edit Fishing Button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingEditView = true
                } label: {
                    Text("Изменить")
                }
            }
//        Add to Favorites Button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.callout)
                        .foregroundStyle(isFavorite ? .red : .primaryDeepBlue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: Fishing.example)
    }
}
