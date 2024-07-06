//
//  WaterInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI
import MapKit

struct WaterInfo: View {
    
    @Binding var water: Water
    @Binding var showOnMap: Bool
        
    var coordinates: CLLocationCoordinate2D {
        return .init(latitude: water.latitude, longitude: water.longitude)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Map(bounds: .bounds(water: water)) {
                Annotation(water.waterName, coordinate: coordinates, anchor: .bottom) {
                                Image(.annotationEmpty)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(height: 157)
            .disabled(true)
            Button(action: {
                showOnMap.toggle()
            }, label: {
                HStack {
                    Image(systemName: "water.waves")
                        .foregroundStyle(.blue)
                        .frame(width: 24, height: 24, alignment: .center)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Название водоема")
                            .font(.footnote)
                            .foregroundStyle(Color.secondary)
                        Text(water.waterName)
                            .font(.system(.body, design: .rounded, weight: .medium))
                            .foregroundColor(.black)
                            .lineLimit(1)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.primaryDeepBlue)
                }
            })
            Divider()
            HStack {
                Image(.locationIcon)
                    .frame(width: 24, height: 24, alignment: .center)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Координаты")
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                    Text(String(format: "%.5f", water.latitude) + " • " + String(format: "%.5f", water.longitude))
                        .font(.system(.body, design: .rounded, weight: .medium))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                Spacer()
                CopyButton(water: $water)
            }
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

#Preview {
    WaterInfo(water: .constant(Fishing.example.water), showOnMap: .constant(false))
}

