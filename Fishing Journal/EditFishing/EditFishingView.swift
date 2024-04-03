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
    
    //Edit Fishing States
    @State private var fishingName: String = ""
    @State private var fishingType: FishingType = .fishingLog
    @State private var fishingMethod: FishingMethod = .bobber
    @State private var fishingTime: Date = .now
    @State private var bait: Bait = .worm
    @State private var fishWeight: Double = 0
    @State private var water: Water = Water(waterName: "", latitude: 54, longitude: 54)
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    
    let shadowColor = Color(white: 0, opacity: 0.1)
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    EF_HeaderView(fishingName: $fishingName, fishingType: $fishingType)
                    EF_ImagesView(fishing: $fishing)
                    EF_FishView(fishing: $fishing, showFishView: $showFishView)
                    EF_FishingInfo(fishing: $fishing, fishingMethod: $fishingMethod, fishingTime: $fishingTime, bait: $bait, fishWeight: $fishWeight)
                    EF_WaterInfo(fishing: $fishing, water: $water, showMapSheet: $showMapSheet, cameraPosition: $cameraPosition)
                    EF_CommentView(fishing: $fishing)
                }
                .shadow(color: shadowColor, radius: 4, x: 0, y: 2)
                .padding(10)
            }
            .interactiveDismissDisabled()
            .onAppear(perform: {
                fishingName = fishing.name
                fishingType = fishing.type
                fishingMethod = fishing.fishingMethod
                fishingTime = fishing.fishingTime
                bait = fishing.bait
                fishWeight = fishing.weight
                water = fishing.water
                cameraPosition = .updateCameraPosition(fishing: fishing)
            })
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(fishing.name)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        showEditView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        fishing.name = fishingName
                        fishing.type = fishingType
                        fishing.fishingMethod = fishingMethod
                        fishing.bait = bait
                        fishing.fishingTime = fishingTime
                        fishing.weight = fishWeight
                        fishing.water = water
                        
                        fishingData.updateFishing(fishing: fishing)
                        showEditView = false
                    }
                }
            }
        .sheet(isPresented: $showFishView) {
            NavigationStack {
                EF_FishPicker(fishing: $fishing)
            }
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showMapSheet, content: {
            EF_EditLocationMapView(fishing: $fishing, water: $water, previewCamera: $cameraPosition)
                .interactiveDismissDisabled()

        })
    }
}

extension MapCameraPosition {
    static func updateCameraPosition(fishing: Fishing) -> MapCameraPosition {
        let location = fishing.water
        let locationSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let locationRegion = MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: locationSpan)
        return self.region(locationRegion)
    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example), showEditView: .constant(false))
}
