//
//  EF_EditLocationMapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 11.03.24.
//

import SwiftUI
import MapKit

struct EF_EditLocationMapView: View {
    
    @EnvironmentObject var fishingData: FishingData
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
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                         newLocation = Water(waterName: fishing.name, latitude: coordinate.latitude, longitude: coordinate.longitude)
                        let newRegion = MKCoordinateRegion(center: coordinate, span: mapSpan)
                        withAnimation(.smooth) {
                            cameraPosition = .region(newRegion)
                        }
                    }
                }
                .onMapCameraChange(frequency: .continuous) { ctx in 
                    mapSpan = ctx.region.span
                }
            }
            .onAppear(perform: {
                let location = fishing.water
                let locationSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let locationRegion = MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: locationSpan)
                cameraPosition = .region(locationRegion)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        fishing.water = newLocation
                        fishingData.updateFishing(fishing: fishing)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена", role: .destructive) {
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
    EF_EditLocationMapView(fishing: .constant(Fishing.example), waterCoordinates: .constant(Fishing.example.water))
}
