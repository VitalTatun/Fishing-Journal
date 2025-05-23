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
    
    @State var viewModel: EditFishingViewModel
    @Binding var showEditView: Bool
    
    let shadowColor = Color(white: 0, opacity: 0.05)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                EF_Header(name: $viewModel.fishingName, type: $viewModel.fishingType)
                EF_ImagesView(viewModel: viewModel)
                EF_FishView(fish: $viewModel.fish, showFishView: $viewModel.showFishView)
                EF_FishingMethodAndBait(showFishingMethodAndBait: $viewModel.showFishingMethodAndBaitSheet, fishingMethod: $viewModel.fishingMethod, bait: $viewModel.bait)
                EF_FishingDetails(fishingType: $viewModel.fishingType, fishingTime: $viewModel.fishingTime, shore: $viewModel.fishingFromTheShore, fishWeight: $viewModel.fishWeight)
                EF_WaterInfo(water: $viewModel.water, showMapSheet: $viewModel.showMapSheet)
                EF_Comment(comment: $viewModel.comment, showCommentView: $viewModel.showCommentView)
            }
            .shadow(color: shadowColor, radius: 6, x: 0, y: 2)
            .padding(10)
        }
        .interactiveDismissDisabled()
        .onAppear(perform: {
            viewModel.setInitialFishingData()
        })
        .background(.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.fishingName)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена") {
                    viewModel.showAlert.toggle()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    viewModel.updateFishingData(fishingData: fishingData, showEditView: &showEditView)
                    showEditView = false
                }
                .disabled(viewModel.validateMandatoryFields())
            }
        }
        .alert("Точно хотите отменить?", isPresented: $viewModel.showAlert, actions: {
            Button("Продолжить редактирование") {
                viewModel.showAlert.toggle()
            }
            Button("Отменить") {
                showEditView.toggle()
                
            }
        }, message: {
            Text("Все внесенные данные не сохранятся")
        })
        
        .sheet(isPresented: $viewModel.showFishView) {
            NavigationStack {
                FishEditView(fish: $viewModel.fish, fishingType: viewModel.fishingType)
            }
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $viewModel.showMapSheet, content: {
            EditLocationMapView(water: $viewModel.water)
                .interactiveDismissDisabled()
        })
        .sheet(isPresented: $viewModel.showCommentView, content: {
            NavigationStack {
                CommentView(comment: $viewModel.comment)
                    .interactiveDismissDisabled()
            }
        })
        .sheet(isPresented: $viewModel.showFishingMethodAndBaitSheet) {
            NavigationStack {
                FishingMethodAndBaitSelectionView(
                        initialMethod: viewModel.fishingMethod,
                        initialBaits: viewModel.bait
                    ) { method, baits in
                        viewModel.fishingMethod = method
                        viewModel.bait = baits
                    }
            }
        }
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
    NavigationStack {
        EditFishingView(viewModel: EditFishingViewModel(fishing: Fishing.example), showEditView: .constant(false))
    }
}
