//
//  EditLocationMapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 11.03.24.
//

import SwiftUI
import MapKit

struct EditLocationMapView: View {
    
    let locationManager = CLLocationManager()
    
    @EnvironmentObject var fishingData: FishingData
    @Environment(\.dismiss) var dismiss

    @Binding var fishing: Fishing
    @Binding var water: Water
    @Binding var previewCamera: MapCameraPosition
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapSpan: MKCoordinateSpan = .init()
    @State private var newLocation: Water = .init(waterName: "", latitude: 0, longitude: 0)
    
    init(fishing: Binding<Fishing>, water: Binding<Water>, previewCamera: Binding<MapCameraPosition>) {
        self._fishing = fishing
        self._newLocation = State(initialValue: fishing.wrappedValue.water)
        self._water = water
        self._previewCamera = previewCamera
    }
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    UserAnnotation()
                    Annotation(fishing.name, coordinate: .init(latitude: newLocation.latitude, longitude: newLocation.longitude), anchor: .bottom) {
                        AnnotationMark(fishing: fishing)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        newLocation = Water(waterName: fishing.water.waterName, latitude: coordinate.latitude, longitude: coordinate.longitude)
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
                cameraPosition = .updateCameraPosition(fishing: fishing)
                locationManager.requestWhenInUseAuthorization()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        water = newLocation
                        previewCamera = cameraPosition
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена", role: .destructive) {
                        dismiss()
                    }
                }
            }
            .navigationTitle(fishing.name)
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
    EditLocationMapView(fishing: .constant(Fishing.example), water: .constant(Fishing.example.water), previewCamera: .constant(.automatic))
}
