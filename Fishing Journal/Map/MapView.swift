//
//  MapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var fishingData: FishingData
    @Environment(\.dismiss) var dismiss

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showFishingLocationDetails = false
    @State private var selectedFishing: Fishing = .emptyFishing
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(fishingData.mockFishings) { fishing in
                Annotation(fishing.name, coordinate: .init(latitude: fishing.water.latitude, longitude: fishing.water.longitude), anchor: .bottom) {
                    AnnotationMark(fishing: fishing)
                    .onTapGesture(perform: {
                        selectedFishing = fishing
                        showFishingLocationDetails = true
                    })
                }
            }
        }
        .mapControls({
            MapUserLocationButton()
        })
        .sheet(isPresented: $showFishingLocationDetails, content: {
            LocationFishingDetailsView(fishing: $selectedFishing, showLocationDetail: $showFishingLocationDetails)
                .presentationDragIndicator(.visible)
        })
    }
}

extension MapCameraBounds {
    static func bounds(water: Water) -> MapCameraBounds {
        let coordinates = CLLocationCoordinate2D(latitude: water.latitude, longitude: water.longitude)
        let region = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000)
        let mapCameraBounds = MapCameraBounds(
            centerCoordinateBounds: region,
            minimumDistance: 4500,
            maximumDistance: 4500)
        return mapCameraBounds
    }
}

#Preview {
    MapView()
        .environmentObject(FishingData())
}
