//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI
import MapKit

struct DetailFishingView: View {
    
    @Binding var fishing: Fishing

    @State private var selectedImage: UIImage?
    @State private var showEditView = false
    @State private var showPhotoView = false
    @State private var showOnMap = false
    @State private var isFavorite = false
    
    let shadowColor = Color(white: 0, opacity: 1)

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $showPhotoView)
                    Header(fishing: fishing)
                    FishCaught(fish: $fishing.fish)
                    FishingInfo(fishing: fishing)
                    WaterInfo(water: $fishing.water, showOnMap: $showOnMap)
                    Comment(fishing: fishing)
                }

                .padding(10)
            }
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        .fullScreenCover(isPresented: $showPhotoView) {
            NavigationStack {
                PhotoView(fishing: fishing, selectedImage: $selectedImage)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Изменить") {
                    showEditView = true
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            NavigationStack {
                EditFishingView(fishing: $fishing, showEditView: $showEditView)
            }
        }
        .sheet(isPresented: $showOnMap) {
            LocationMapView(water: $fishing.water)
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.example))
    }
}

