//
//  EditFishingViewModel.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 13.05.25.
//

import MapKit
import SwiftUI

class EditFishingViewModel: ObservableObject {
    @Published var fishing: Fishing
    @Published var fishingName: String = ""
    @Published var fishingType: FishingType = .fishingLog
    @Published var fish: [Fish] = []
    @Published var fishingMethod: FishingMethod = .none
    @Published var fishingTime: Date = .now
    @Published var bait: [Bait] = [.none]
    @Published var fishWeight: Double = 0
    @Published var water: Water = Water(waterName: "", latitude: 54, longitude: 54)
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var comment: String = ""
    @Published var fishingFromTheShore: Bool = true
    @Published var images: [UIImage?] = []
    @Published var selectedItem: UIImage?
    
    
    @Published var showAlert: Bool = false
    @Published var showFishView: Bool = false
    @Published var showMapSheet: Bool = false
    @Published var showCommentView: Bool = false
    @Published var showFishingMethodAndBaitSheet: Bool = false

    init(fishing: Fishing) {
        self.fishing = fishing
        setInitialFishingData()
    }

    func setInitialFishingData() {
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

    func updateFishingData(fishingData: FishingData, showEditView: inout Bool) {
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
        showEditView = false
    }

//    func validateMandatoryFields() -> Bool {
//        fishingName.isEmpty || fish.isEmpty || water.waterName.isEmpty || water.latitude.isZero
//    }
    
    func validateMandatoryFields() -> Bool {
        fishingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        fish.isEmpty ||
        fishingMethod == .none ||
        bait.isEmpty || bait.allSatisfy { $0 == .none } ||
        water.waterName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        water.latitude == 0 || water.longitude == 0
    }
    

}

