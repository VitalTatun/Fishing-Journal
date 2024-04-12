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
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    Annotation(water.waterName, coordinate: .init(latitude: newLocation.latitude, longitude: newLocation.longitude), anchor: .bottom) {
                        Image(.annotationEmpty)
                    }
                }
                .onMapCameraChange(frequency: .continuous) { action in
                    mapSpan = action.region.span
                }
            }
            .onAppear(perform: {
                cameraPosition = .updateCameraPosition(water: water)

            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад") {
                        dismiss()
                    }
                }
            })
            .navigationTitle(water.waterName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    LocationMapView(water: .constant(Fishing.example.water))
}
