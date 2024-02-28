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
    @State private var showDetails = false
    @State private var selectedFishing: Fishing = .emptyFishing
    @State private var activeMark: Bool = false
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(fishingData.mockFishings) { fishing in
                Annotation(fishing.name, coordinate: .init(latitude: fishing.water.latitude, longitude: fishing.water.longitude)) {
                    AnnotationMark(fishing: fishing, active: $activeMark)
                    .onTapGesture(perform: {
                        selectedFishing = fishing
                        showDetails = true
                    })
                }

            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .sheet(isPresented: $showDetails, content: {
            LocationFishingDetailsView(fishing: $selectedFishing, showLocationDetail: $showDetails)
                .presentationBackgroundInteraction(.enabled)
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
                     latitudinalMeters: 10000,
                     longitudinalMeters: 10000)
    }
}

#Preview {
    MapView()
        .environmentObject(FishingData())
}
