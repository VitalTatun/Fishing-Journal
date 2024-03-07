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
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(fishing.water.waterName)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.black)
                    Text(String(fishing.water.latitude) + " • " + String(fishing.water.longitude))
                        .font(.footnote)
                        .foregroundColor(.primaryDeepBlue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()
                Button {
                    let pasteboard = UIPasteboard.general
                    let coordinates = String(fishing.water.latitude) + " " + String(fishing.water.longitude)
                    pasteboard.string = coordinates
                } label: {
                    Image(systemName: "square.on.square")
                        .foregroundStyle(.primaryDeepBlue)
                        .frame(width: 34, height: 34, alignment: .center)
                        .background(.lightBlue)
                        .clipShape(Circle())
                }
            }
            mapLayer
            Button {
                } label: {
                    Text("Показать на карте")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .frame(height: 36)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.primaryDeepBlue)
                        .cornerRadius(5)
                }
                .buttonStyle(.plain)
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(lineWidth: 1)
                .foregroundColor(.black.opacity(0.18))
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
                .frame(height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .disabled(true)
        }
    }
}


#Preview {
    WaterInfo(fishing: Fishing.example)
}

