//
//  EditLocationMapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 11.03.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct EditLocationMapView: View {
    
    let locationManager = CLLocationManager()
    
    @EnvironmentObject var fishingData: FishingData
    @Environment(\.dismiss) var dismiss

    @Binding var water: Water
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapSpan: MKCoordinateSpan = .init(latitudeDelta: 0.3, longitudeDelta: 0.3)
    @State private var newLocation: Water = .init(waterName: "", latitude: 0, longitude: 0)
    
    init(water: Binding<Water>) {
        self._newLocation = State(wrappedValue: water.wrappedValue)
        self._water = water
    }
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    UserAnnotation()
                    Annotation(water.waterName, coordinate: .init(latitude: newLocation.latitude, longitude: newLocation.longitude), anchor: .bottom) {
                        Image(.annotationEmpty)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        newLocation = Water(waterName: water.waterName, latitude: coordinate.latitude, longitude: coordinate.longitude)
                        let newRegion = MKCoordinateRegion(center: coordinate, span: mapSpan)
                        withAnimation(.smooth) {
                            cameraPosition = .region(newRegion)
                        }
                    }
                    findCoordinateName()
                }
                .onMapCameraChange(frequency: .continuous) { context in
                    mapSpan = context.region.span
                }
            }
            .onAppear(perform: {
                cameraPosition = .updateCameraPosition(water: water)
                locationManager.requestWhenInUseAuthorization()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        water = newLocation
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена", role: .destructive) {
                        dismiss()
                    }
                }
            }
            .navigationTitle(water.waterName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func findCoordinateName() {
        Task {
            let location = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
            let decoder = CLGeocoder()
            if let name = try? await decoder.reverseGeocodeLocation(location).first?.inlandWater {
                newLocation.waterName = name
            }
        }
    }
}

#Preview {
    EditLocationMapView(water: .constant(Fishing.example.water))
}
