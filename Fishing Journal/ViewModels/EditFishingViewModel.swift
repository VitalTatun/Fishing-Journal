//
//  EditFishingViewModel.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 13.05.25.
//

import MapKit
import SwiftUI
import PhotosUI
import Observation

@Observable
class EditFishingViewModel: Observable {
   var fishing: Fishing
   var fishingName: String = ""
   var fishingType: FishingType = .fishingLog
   var fish: [Fish] = []
   var fishingMethod: FishingMethod = .none
   var fishingTime: Date = .now
   var bait: [Bait] = [.none]
   var fishWeight: Double = 0
   var water: Water = Water(waterName: "", latitude: 54, longitude: 54)
   var cameraPosition: MapCameraPosition = .automatic
   var comment: String = ""
   var fishingFromTheShore: Bool = true
   var images: [UIImage?] = []
   var selectedItem: UIImage?
    
    
    var showAlert: Bool = false
    var showFishView: Bool = false
    var showMapSheet: Bool = false
    var showCommentView: Bool = false
    var showFishingMethodAndBaitSheet: Bool = false

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

    func validateMandatoryFields() -> Bool {
        // Общие обязательные поля
        let isBaseInvalid =
            fishingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            fishingMethod == .none ||
            bait.isEmpty || bait.allSatisfy { $0 == .none } ||
            water.waterName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            water.latitude == 0 || water.longitude == 0

        // Дополнительные условия по типу рыбалки
        switch fishingType {
        case .fishingLog:
            return isBaseInvalid || fish.isEmpty
        case .haul:
            let hasPhoto = images.contains(where: { $0 != nil })
            return isBaseInvalid || fish.count != 1 || !hasPhoto
        }
    }

}

// MARK: - Image Handling

extension EditFishingViewModel {
    func addImages(from pickerItems: [PhotosPickerItem]) async {
        for item in pickerItems {
            if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data),
                       images.count < 6 {
                        await MainActor.run {
                            images.append(image)
                            selectedItem = nil
                        }
                    }
        }
    }
    
    func removeImage(_ image: UIImage) {
        if let index = images.firstIndex(where: { $0 == image }) {
            images.remove(at: index)
        }
    }
}
