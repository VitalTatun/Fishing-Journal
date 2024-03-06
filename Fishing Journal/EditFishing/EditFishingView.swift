//
//  EditFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 13.02.24.
//

import Foundation
import SwiftUI

struct EditFishingView: View {
    
    @EnvironmentObject var fishingData: FishingData

    @Binding var fishing: Fishing
    @Binding var showEditView: Bool
    @State private var showFishView = false
    
    //Edit Fishing States
    @State private var fishingName: String = ""
    @State private var fishingType: FishingType = .fishingLog
    
    @State private var fishingMethod: FishingMethod = .bobber
    @State private var fishingTime: Date = .now
    @State private var bait: Bait = .worm
    @State private var fishWeight: Double = 0
    
    let shadowColor = Color(white: 0, opacity: 0.1)
    
    init(fishing: Binding<Fishing>, showEditView: Binding<Bool>) {
        self._fishing = fishing
        self._fishingName = State(initialValue: fishing.wrappedValue.name)
        self._fishingType = State(initialValue: fishing.wrappedValue.type)
        self._fishingMethod = State(initialValue: fishing.wrappedValue.fishingMethod)
        self._bait = State(initialValue: fishing.wrappedValue.bait)
        self._fishingTime = State(initialValue: fishing.wrappedValue.fishingTime)
        self._fishWeight = State(initialValue: fishing.wrappedValue.weight)
        self._showEditView = showEditView
    }
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    EF_HeaderView(fishing: $fishing, fishingName: $fishingName, fishingType: $fishingType)
                    EF_ImagesView(fishing: $fishing)
                    EF_FishView(fishing: $fishing, showFishView: $showFishView)
                    EF_FishingInfo(fishing: $fishing, fishingMethod: $fishingMethod, fishingTime: $fishingTime, bait: $bait, fishWeight: $fishWeight)
                    EF_CommentView(fishing: $fishing)

                }
                .shadow(color: shadowColor, radius: 4, x: 0, y: 2)
                .padding(10)
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(fishing.name)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bookmark")
                    })
                }
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
                        fishingData.updateFishing(fishing: fishing)
                        showEditView = false
                    }
                }
            }
        .sheet(isPresented: $showFishView) {
            NavigationStack {
                EF_FishPicker(fishing: $fishing)
            }
        }
    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example), showEditView: .constant(false))
}
