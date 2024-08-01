//
//  FishEditViewModel.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.07.24.
//

import Foundation
import SwiftUI

class FishEditViewModel: ObservableObject {
    
    @Published var fishToEditList: [Fish] = []
    @Published var newFish: String = ""
    @Published var showAlert: Bool = false  

    
    func checkTheSameFishInList() {
        if fishToEditList.contains(where: { $0.name == newFish }) {
            showAlert = true
        } else {
            withAnimation(.easeIn) {
                addNewFish(fish: newFish)
            }
        }
    }
    func addNewFish(fish: String) {
        let newFish = Fish(name: fish, count: 1)
        fishToEditList.append(newFish)
        self.newFish = ""
    }
    
}
