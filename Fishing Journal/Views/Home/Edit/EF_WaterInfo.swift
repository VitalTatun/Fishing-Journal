//
//  EF_WaterInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI
import MapKit

struct EF_WaterInfo: View {
    
    @Binding var water: Water
    @Binding var showMapSheet: Bool    
        
    private let sectionTitle: String = "Местоположение на карте"
    private let sectionSecondary: String = "Название и координаты на карте"
    private let textFieldPromt: String = "Напишите сюда название водоема"
    private let footerText: String = "Напишите название водоема или тип, например - река, озеро и т.д. Можно также добавить соседний населенный пункт."
    private let mapSectionTitle: String = "Координаты"
    private let mapSectionSecondary: String = "Нажмите + чтобы добавить место ловли"
    private let mapFooterText: String = "Необязательно указывать точное место, можно просто указать водоем."
    private let format = "%.5f"
    
    private var coordinates: CLLocationCoordinate2D {
        return .init(latitude: water.latitude, longitude: water.longitude)
    }
    private var icon: String {
        if water.latitude != .zero {
            return "chevron.right"
        } else {
            return "plus"
        }
    }
    
    private var waterCoordinates: String {
        if water.latitude != .zero {
            return "Координаты GPS: " + String(format: format, water.latitude) + " - " + String(format: format, water.longitude)
        } else {
            return String(mapSectionSecondary)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            section(title: sectionTitle, secondary: waterCoordinates)
            Divider()
            HStack(alignment: .center, spacing: 10) {
                TextField(textFieldPromt, text: $water.waterName)
                    .fontWeight(.medium)
                    .textFieldStyle(.plain)
                    .frame(height: 44)
                Button {
                    
                    // Show Tip about fishing naming with text - Напишите название водоема или тип, например - река, озеро и т.д. Можно также добавить соседний населенный пункт.
                } label: {
                    Image(systemName: "info.circle")
                        .font(.body)
                        .foregroundStyle(.blue)
                }
            }
            .padding(.horizontal, 16)
            .overlay(alignment: .topLeading) {
                Circle()
                    .foregroundStyle(.red)
                    .offset(x: 6, y: 6)
                    .frame(width: 6, height: 6)
            }
            Divider()
            if water.latitude != .zero {
                mapView()
            }
        }
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(.red)
                .offset(x: 6, y: 6)
                .frame(width: 6, height: 6)
        }
    }
    @ViewBuilder
    func section(title: String, secondary: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(secondary)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: {
                showMapSheet = true
            }, label: {
                Image(systemName: icon)
                    .fontWeight(.medium)
                    .tint(.primary)
            })
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func mapView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Map(bounds: .bounds(water: water)) {
                Annotation(water.waterName, coordinate: coordinates, anchor: .bottom) {
                                Image(.annotationEmpty)
                }
            }
            .frame(height: 157)
            .disabled(true)
        }
    }
}

#Preview {
    EF_WaterInfo(water: .constant(Fishing.example.water), showMapSheet: .constant(false))
}

#Preview("Empty Fishing") {
    EF_WaterInfo(water: .constant(Fishing.emptyFishing.water), showMapSheet: .constant(false))
}
