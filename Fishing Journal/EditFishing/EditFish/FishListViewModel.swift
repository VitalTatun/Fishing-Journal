//
//  FishListViewModel.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 13.05.25.
//

import Foundation
import SwiftUI

class FishListViewModel: ObservableObject {
    @Published var fishToEditList: [Fish]
    @Published var showAlert: Bool = false
    @Published var newFish: String = ""
    
    let fishingType: FishingType
    
    init(fish: [Fish], fishingType: FishingType) {
        self.fishToEditList = fish
        self.fishingType = fishingType
    }
    
    var alertText: String {
        return "\(newFish) уже есть в списке. Просто отредактируйте количество."
    }
    
    func checkTheSameFishInList() {
        
        guard fishingType == .fishingLog || fishToEditList.count == 0 else {
            showAlert = true
            return
        }
        
        if fishToEditList.contains(where: { $0.name == newFish }) {
            showAlert = true
        } else {
            withAnimation(.easeIn) {
                addNewFish(fish: newFish)
            }
        }
    }
    
    func addFishFromTemplate(_ fish: Fish) {
        if fishingType == .haul && fishToEditList.count >= 1 {
            showAlert = true
            return
        }
        if fishToEditList.contains(where: { $0.name == fish.name }) {
            showAlert = true
        } else {
            withAnimation(.easeIn) {
                fishToEditList.append(fish)
            }
        }
    }
    
    private func addNewFish(fish: String) {
        let newFish = Fish(name: fish, count: 1)
        fishToEditList.append(newFish)
        self.newFish = ""
    }
}
