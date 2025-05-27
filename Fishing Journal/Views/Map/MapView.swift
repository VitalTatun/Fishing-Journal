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
    @State private var selectedMarker: Fishing?
    
    var body: some View {

        Map(position: $cameraPosition, selection: $selectedMarker) {
            UserAnnotation()
            ForEach($fishingData.mockFishings) { $fishing in
                Marker(coordinate: .init(latitude: fishing.water.latitude, longitude: fishing.water.longitude)) {
                    Label(fishing.name, image: fishing.fishingMethod.icon)
                }.tag(fishing)
            }
        }
        .mapControls({
            MapUserLocationButton()
        })
        .fullScreenCover(item: $selectedMarker, content: { fishing in
            NavigationStack {
                LocationFishingDetailsView(fishing: fishing)
            }
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
