//
//  WaterInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI
import MapKit

struct WaterInfo: View {
    
    let fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Водоем")
                .font(.headline)
                .foregroundColor(.primaryDeepBlue)
            mapLayer
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(fishing.water.waterName)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.black)
                    Text(String(fishing.water.latitude) + " • " + String(fishing.water.longitude))
                        .font(.subheadline)
                        .foregroundColor(.primaryDeepBlue)
                }
                Spacer()
                Image(systemName: "doc.on.doc.fill")
            }
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(lineWidth: 1)
                .foregroundColor(.secondary)
        }
    }
}

extension WaterInfo {
    private var mapLayer: some View {
        HStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: fishing.water.latitude, longitude: fishing.water.longitude), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))),
                annotationItems: [fishing]) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: fishing.water.latitude, longitude: fishing.water.longitude))
            }
                .frame(height: 157)
                .cornerRadius(10)
                .disabled(true)
        }
    }
}


#Preview {
    WaterInfo(fishing: Fishing.example)
}

