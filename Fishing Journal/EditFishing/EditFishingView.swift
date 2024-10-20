//
//  EditFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 13.02.24.
//

import Foundation
import SwiftUI
import MapKit

struct EditFishingView: View {
    
    @EnvironmentObject var fishingData: FishingData
    
    @Binding var fishing: Fishing
    @Binding var showEditView: Bool
    
    @State private var showFishView = false
    @State private var showMapSheet = false
    @State private var showCommentView = false
    @State private var showAlert: Bool = false
    
    //Edit Fishing States
    @State private var fishingName: String = ""
    @State private var fishingType: FishingType = .fishingLog
    @State private var fish: [Fish] = []
    @State private var fishingMethod: FishingMethod = .bobber
    @State private var fishingTime: Date = .now
    @State private var bait: Bait = .worm
    @State private var fishWeight: Double = 0
    @State private var water: Water = Water(waterName: "", latitude: 54, longitude: 54)
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var comment: String = ""
    @State private var fishingFromTheShore: Bool = true
    
    //Edit Images States
    @State private var images: [UIImage?] = []
    @State private var selectedItem: UIImage?
    
    let shadowColor = Color(white: 0, opacity: 0.05)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                EF_HeaderView(fishingName: $fishingName, fishingType: $fishingType)
                EF_ImagesView(images: $images, selectedItem: $selectedItem)
                EF_FishView(fish: $fish, showFishView: $showFishView)
                EF_FishingInfo(fishingMethod: $fishingMethod, fishingTime: $fishingTime, bait: $bait, fishWeight: $fishWeight, shore: $fishingFromTheShore)
                EF_WaterInfo(water: $water, showMapSheet: $showMapSheet)
                EF_Comment(comment: $comment, showCommentView: $showCommentView)
            }
            .shadow(color: shadowColor, radius: 6, x: 0, y: 2)
            .padding(10)
        }
        .interactiveDismissDisabled()
        .onAppear(perform: {
            setInitialFishingData()
        })
        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(fishing.name)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена") {
                    showAlert.toggle()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    updateFishingData()
                    showEditView = false
                }
                .disabled(fish.isEmpty)
            }
        }
        .alert("Точно хотите отменить?", isPresented: $showAlert, actions: {
            Button("Продолжить редактирование") {
                showAlert.toggle()
            }
            Button("Отменить", role: .cancel) {
                showEditView.toggle()
            }
        }, message: {
            Text("Все внесенные данные не сохранятся")
        })
        .sheet(isPresented: $showFishView) {
            NavigationStack {
                FishEditView(fish: $fish)
            }
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showMapSheet, content: {
            EditLocationMapView(water: $water)
                .interactiveDismissDisabled()
        })
        .sheet(isPresented: $showCommentView, content: {
            NavigationStack {
                CommentView(comment: $comment)
                    .interactiveDismissDisabled()
            }
        })
        
    }
    private func setInitialFishingData() {
        fishingName = fishing.name
        fishingType = fishing.type
        fish = fishing.fish
        fishingMethod = fishing.fishingMethod
        fishingTime = fishing.fishingTime
        bait = fishing.bait
        fishWeight = fishing.weight
        water = fishing.water
        cameraPosition = .updateCameraPosition(fishing: fishing)
        comment = fishing.comment
        images = fishing.photo
        fishingFromTheShore = fishing.fishingFromTheShore
    }
    private func updateFishingData() {
        fishing.name = fishingName
        fishing.type = fishingType
        fishing.fish = fish
        fishing.fishingMethod = fishingMethod
        fishing.bait = bait
        fishing.fishingTime = fishingTime
        fishing.weight = fishWeight
        fishing.water = water
        fishing.comment = comment
        fishing.photo = images
        fishing.fishingFromTheShore = fishingFromTheShore
        
        fishingData.updateFishing(fishing: fishing)
    }
    
    func validation(type: FishingType) -> Bool {
        if fishingName.isEmpty && fish.isEmpty {
            return true
        }
        return false
    }
    
}

extension MapCameraPosition {
    static func updateCameraPosition(fishing: Fishing) -> MapCameraPosition {
        let location = fishing.water
        let coordinates = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let locationRegion =
        MKCoordinateRegion(center: coordinates, latitudinalMeters: 3000, longitudinalMeters: 3000)
        return self.region(locationRegion)
    }
    
    static func updateCameraPosition(water: Water) -> MapCameraPosition {
        let location = water
        let coordinates = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let locationRegion =
        MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
        return self.region(locationRegion)
    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example), showEditView: .constant(false))
}
