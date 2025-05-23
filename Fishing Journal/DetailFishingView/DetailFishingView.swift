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
    
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, showImage: $showPhotoView, animation: animation)
                    Header(fishing: fishing)
                    FishCaught(fish: fishing.fish)
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
        .fullScreenCover(isPresented: $showPhotoView, content: {
            if let selectedImage {
                ImageView(selectedImage: selectedImage, animation: animation)
                    .ignoresSafeArea()
            }
        })
        .sheet(isPresented: $showEditView) {
            NavigationStack {
                EditFishingView(
                    viewModel: EditFishingViewModel(fishing: fishing),
                    showEditView: $showEditView
                )
            }
        }
        .fullScreenCover(isPresented: $showOnMap) {
            NavigationStack {
                LocationMapView(water: $fishing.water)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Изменить") {
                    showEditView = true
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.mock))
    }
}

