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
        
    private let sectionTitle: String = "Информация о водоеме"
    private let sectionSecondary: String = "Название и координаты на карте"
    private let textFieldPromt: String = "Напишите сюда название водоема"
    private let footerText: String = "Напишите название водоема или тип, например - река, озеро и т.д. Можно также добавить соседний населенный пункт."
    private let mapSectionTitle: String = "Координаты"
    private let mapSectionSecondary: String = "Нажмите + чтобы добавить место ловли"
    private let mapFooterText: String = "Необязательно указывать точное место, можно просто указать водоем."
    private let format = "%.5f"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            EF_Section(title: sectionTitle, secondary: sectionSecondary)
            VStack(alignment: .leading, spacing: 5) {
                TextField(textFieldPromt,text: $water.waterName)
                    .textFieldStyle(OvalTextFieldStyle())
                Text(footerText)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Divider()
            }
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(mapSectionTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    if water.latitude != .zero {
                        Text(String(format: format, water.latitude) + " - " + String(format: format, water.longitude))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        Text(mapSectionSecondary)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Button {
                    showMapSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryDeepBlue)
                }
                .frame(height: 34)
            }
            if water.latitude != .zero {
                VStack(alignment: .leading, spacing: 5) {
                    let coordinates: CLLocationCoordinate2D = .init(latitude: water.latitude, longitude: water.longitude)
                    Map(bounds: .bounds(water: water)) {
                        Annotation(water.waterName, coordinate: coordinates, anchor: .bottom) {
                                        Image(.annotationEmpty)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(height: 157)
                    .disabled(true)
                    Text(mapFooterText)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    func coord2String(coordinates: CLLocationCoordinate2D) -> String {
        return String(coordinates.latitude) + " " + String(coordinates.longitude)
    }
}

#Preview {
    EF_WaterInfo(water: .constant(Fishing.example.water), showMapSheet: .constant(false))
}

#Preview("Empty Fishing") {
    EF_WaterInfo(water: .constant(Fishing.emptyFishing.water), showMapSheet: .constant(false))
}
