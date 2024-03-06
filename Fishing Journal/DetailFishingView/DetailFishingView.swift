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
    @State private var showEditView = false
    @State private var showPhotoView = false
    @State private var isFavorite = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $showPhotoView)
                    Header(fishing: fishing)
                    FishCaught(fishing: fishing)
                    FishingInfo(fishing: fishing)
                    WaterInfo(fishing: fishing)
                    Comment(fishing: fishing)
                }
                .padding(10)
            }
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        .fullScreenCover(isPresented: $showPhotoView, content: {
            NavigationStack {
                PhotoView(fishing: fishing, selectedImage: $selectedImage)
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditView = true
                } label: {
                    Text("Изменить")
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            NavigationStack {
                EditFishingView(fishing: $fishing, showEditView: $showEditView)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.example))
    }
}

