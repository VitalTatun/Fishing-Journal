//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct DetailFishingView: View {
    
    @Binding var fishing: Fishing
    @State private var selectedImage: String?
    
    @State private var isPresentingEditView = false
    @State private var isPresentingPhotoView = false
    
    @State private var fishingToEdit = Fishing.emptyFishing
    
    @State private var isFavorite = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $isPresentingPhotoView)
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
                    fishingToEdit = fishing
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
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EditFishingView(fishing: $fishing)
                    
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.example))
    }
}

