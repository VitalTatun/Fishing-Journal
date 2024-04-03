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
    @Binding var fishing: Fishing
    @Binding var waterCoordinates: Water
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapSpan: MKCoordinateSpan = .init()
    @State private var newLocation: Water = .init(waterName: "", latitude: 0, longitude: 0)
    
    init(fishing: Binding<Fishing>, waterCoordinates: Binding<Water>) {
        self._fishing = fishing
        self._newLocation = State(initialValue: fishing.wrappedValue.water)
        self._waterCoordinates = waterCoordinates
    }
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    Annotation(fishing.name, coordinate: .init(latitude: newLocation.latitude, longitude: newLocation.longitude), anchor: .bottom) {
                        AnnotationMark(fishing: fishing)
                    }
                }
                .onMapCameraChange(frequency: .continuous) { action in
                    mapSpan = action.region.span
                }
            }
            .onAppear(perform: {
                let location = fishing.water
                let locationSpan = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
                let locationRegion = MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: locationSpan)
                cameraPosition = .region(locationRegion)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад") {
                        dismiss()
                    }
                }
            })
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    LocationMapView(fishing: .constant(Fishing.example), waterCoordinates: .constant(Fishing.example.water))
}
