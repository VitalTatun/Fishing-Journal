//
//  MapView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @EnvironmentObject var fishingData: FishingData
    @StateObject private var locationObserver = LocationObserver()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedMarker: Fishing?
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var isClusterMode = false
    @State private var selectedCluster: FishingCluster?
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selectedMarker) {
            UserAnnotation()
            if isClusterMode {
                ForEach(clusteredFishings) { cluster in
                    Annotation("", coordinate: cluster.coordinate) {
                        Button {
                            handleClusterTap(cluster)
                        } label: {
                            ClusterAnnotationView(count: cluster.count)
                        }
                        .buttonStyle(.plain)
                    }
                }
            } else {
                ForEach(fishingData.mockFishings) { fishing in
                    Marker(coordinate: .init(latitude: fishing.water.latitude, longitude: fishing.water.longitude)) {
                        Label(fishing.name, image: fishing.fishingMethod.icon)
                    }
                    .tag(fishing)
                }
            }
        }
        .mapControls({
            MapUserLocationButton()
        })
        .onMapCameraChange(frequency: .onEnd) { context in
            updateVisibleRegion(context.region)
        }
        .fullScreenCover(item: $selectedMarker, content: { fishing in
            NavigationStack {
                LocationFishingDetailsView(fishing: fishing)
            }
        })
        .sheet(item: $selectedCluster) { cluster in
            ClusterFishingsSheet(cluster: cluster) { fishing in
                selectedCluster = nil
                selectedMarker = fishing
            }
            .presentationDetents([.fraction(0.3), .medium, .large])
            .presentationDragIndicator(.visible)
        }
        .overlay(alignment: .bottomTrailing) {
            Button(action: centerOnUserLocation) {
                Image(systemName: "location.fill")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.primaryDeepBlue, in: Circle())
            }
            .disabled(locationObserver.currentLocation == nil)
            .opacity(locationObserver.currentLocation == nil ? 0.5 : 1)
            .padding(.trailing, 16)
            .padding(.bottom, 24)
        }
        .onAppear {
            locationObserver.requestAccess()
        }
        .task {
            await fishingData.loadFishings()
        }
    }

    private var clusteredFishings: [FishingCluster] {
        guard let visibleRegion else { return [] }

        let latitudeStep = max(visibleRegion.span.latitudeDelta / 6, 0.01)
        let longitudeStep = max(visibleRegion.span.longitudeDelta / 6, 0.01)

        let grouped = Dictionary(grouping: fishingData.mockFishings) { fishing in
            ClusterKey(
                latitudeBucket: Int((fishing.water.latitude / latitudeStep).rounded(.down)),
                longitudeBucket: Int((fishing.water.longitude / longitudeStep).rounded(.down))
            )
        }

        return grouped.values.map { fishings in
            let latitudes = fishings.map(\.water.latitude)
            let longitudes = fishings.map(\.water.longitude)
            let center = CLLocationCoordinate2D(
                latitude: latitudes.reduce(0, +) / Double(latitudes.count),
                longitude: longitudes.reduce(0, +) / Double(longitudes.count)
            )

            return FishingCluster(
                id: fishings.map(\.id).sorted { $0.uuidString < $1.uuidString }.map(\.uuidString).joined(separator: "-"),
                coordinate: center,
                count: fishings.count,
                latitudeRange: (latitudes.min() ?? center.latitude)...(latitudes.max() ?? center.latitude),
                longitudeRange: (longitudes.min() ?? center.longitude)...(longitudes.max() ?? center.longitude),
                fishings: fishings
            )
        }
    }

    private func centerOnUserLocation() {
        guard let location = locationObserver.currentLocation else { return }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
        )
    }

    private func zoomToCluster(_ cluster: FishingCluster) {
        let latitudeDelta = max((cluster.latitudeRange.upperBound - cluster.latitudeRange.lowerBound) * 1.8, 0.02)
        let longitudeDelta = max((cluster.longitudeRange.upperBound - cluster.longitudeRange.lowerBound) * 1.8, 0.02)

        withAnimation(.easeInOut(duration: 0.35)) {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: cluster.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
                )
            )
        }
    }

    private func updateVisibleRegion(_ region: MKCoordinateRegion) {
        visibleRegion = region
        selectedCluster = nil

        let showThreshold = 0.10
        let hideThreshold = 0.06
        let maxSpan = max(region.span.latitudeDelta, region.span.longitudeDelta)

        if isClusterMode {
            if maxSpan < hideThreshold {
                isClusterMode = false
            }
        } else if maxSpan > showThreshold {
            isClusterMode = true
        }
    }

    private func handleClusterTap(_ cluster: FishingCluster) {
        if shouldShowClusterSheet(cluster) {
            selectedCluster = cluster
        } else {
            zoomToCluster(cluster)
        }
    }

    private func shouldShowClusterSheet(_ cluster: FishingCluster) -> Bool {
        guard cluster.count > 1 else { return false }
        let latitudeDelta = cluster.latitudeRange.upperBound - cluster.latitudeRange.lowerBound
        let longitudeDelta = cluster.longitudeRange.upperBound - cluster.longitudeRange.lowerBound
        return max(latitudeDelta, longitudeDelta) < 0.0015
    }
}

private struct ClusterKey: Hashable {
    let latitudeBucket: Int
    let longitudeBucket: Int
}

private struct FishingCluster: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let count: Int
    let latitudeRange: ClosedRange<Double>
    let longitudeRange: ClosedRange<Double>
    let fishings: [Fishing]
}

private struct ClusterAnnotationView: View {
    let count: Int

    var body: some View {
        Text("\(count)")
            .font(.headline)
            .foregroundStyle(.white)
            .frame(minWidth: 40, minHeight: 40)
            .padding(6)
            .background(.primaryDeepBlue, in: Circle())
    }
}

private struct ClusterFishingsSheet: View {
    let cluster: FishingCluster
    let onSelect: (Fishing) -> Void

    private var sortedFishings: [Fishing] {
        cluster.fishings.sorted { $0.fishingTime > $1.fishingTime }
    }

    var body: some View {
        NavigationStack {
            List(sortedFishings) { fishing in
                Button {
                    onSelect(fishing)
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(fishing.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text(fishing.water.waterName)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(fishing.fishingTime.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Отчеты: \(cluster.count)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private final class LocationObserver: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published private(set) var currentLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestAccess() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            currentLocation = locations.last
        }
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
        .environmentObject(FishingData(previewFishings: FishingData.previewFishings))
}
