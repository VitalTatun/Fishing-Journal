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

    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var showFishingLocationDetails = false
    @State private var selectedFishing: Fishing = .emptyFishing
    
    var body: some View {
        Map(position: $cameraPosition) {
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
        .sheet(isPresented: $showFishingLocationDetails, content: {
            LocationFishingDetailsView(fishing: $selectedFishing, showLocationDetail: $showFishingLocationDetails)
                .presentationDragIndicator(.visible)
        })
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 53.95446, longitude: 27.36887)
    }
}
extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 3000,
                     longitudinalMeters: 3000)
    }
}

#Preview {
    MapView()
        .environmentObject(FishingData())
}
