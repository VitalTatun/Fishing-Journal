//
//  LocationOnMapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.03.24.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var region = MKCoordinateRegion()
    @Binding var water: Water
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapSpan: MKCoordinateSpan = .init()
    @State private var newLocation: Water = .init(waterName: "", latitude: 0, longitude: 0)
    
    init(water: Binding<Water>) {
        self._water = water
        self._newLocation = State(initialValue: water.wrappedValue)
    }
    
    var body: some View {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    Annotation(water.waterName, coordinate: .init(latitude: newLocation.latitude, longitude: newLocation.longitude), anchor: .bottom) {
                        Image(.annotationEmpty)
                    }
                }
                .onMapCameraChange(frequency: .continuous) { action in
                    mapSpan = action.region.span
                }
                .mapControls {
                    MapUserLocationButton()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                                VStack {
                                    Text(water.waterName).font(.headline)
                                    Text("\(water.latitude) - \(water.longitude)").font(.subheadline)
                                }
                            }
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                    }
                    .tint(.primaryDeepBlue)
                }

            }
        .onAppear(perform: {
            cameraPosition = .updateCameraPosition(water: water)
        })
    }
    
}

#Preview {
    LocationMapView(water: .constant(Fishing.example.water))
}
