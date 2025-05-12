//
//  FishingViewModel.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 8.05.25.
//

import Foundation

class FishingViewModel: ObservableObject {
    
    @Published var selectedMethod: FishingMethod {
        didSet {
            updateBaitsForSelectedMethod()
        }
    }
    @Published var availableBaits: [Bait] = []
    @Published var selectedBaits: Set<Bait> = []
    
    private let methodsAndBaits: [FishingMethod: [Bait]] = [
        .bobber: [.worm, .maggot, .bloodworm, .barley, .corn, .bread, .potato, .semolina],
        .feeder: [.worm, .maggot, .bloodworm, .barley, .corn, .bread, .potato, .semolina],
        .spinning: [.spoonbait, .wobbler, .edibleRubber],
        .flyFishing: [.fly, .grasshopper, .butterfly]
    ]

    init(initialMethod: FishingMethod, initialBait: [Bait]) {
        self.selectedMethod = initialMethod
        self.selectedBaits = Set(initialBait)
        self.availableBaits = methodsAndBaits[initialMethod] ?? []
    }

    private func updateBaitsForSelectedMethod() {
            availableBaits = methodsAndBaits[selectedMethod] ?? []
            selectedBaits.removeAll()
        }
    
    func toggleBait(_ bait: Bait) {
        if selectedBaits.contains(bait) {
            selectedBaits.remove(bait)
        } else {
            selectedBaits.insert(bait)
        }
    }
}
