//
//  EF_WaterInfo.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI
import MapKit

struct EF_WaterInfo: View {
    
    @Binding var fishing: Fishing
    @Binding var water: Water
    @Binding var showMapSheet: Bool
    @Binding var cameraPosition: MapCameraPosition
    
    let sectionTitle: String = "Информация о водоеме"
    let sectionSecondary: String = "Название и координаты на карте"
    let textFieldPromt: String = "Напишите сюда название водоема"
    let footerText: String = "Напишите название водоема или тип, например - река, озеро и т.д. Можно также добавить соседний населенный пункт."
    let mapSectionTitle: String = "Координаты"
    let mapSectionSecondary: String = "Нажмите + чтобы добавить место ловли"
    let mapFooterText: String = "Нажмите чтобы указать место ловли. Необязательно указывать точное место, можно просто указать водоем."
    let format = "%.5f"
    
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
                            .foregroundColor(.primaryDeepBlue)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .background(.lightBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
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
                    Map(position: $cameraPosition) {
                        Annotation(water.waterName, coordinate: .init(latitude: water.latitude, longitude: water.longitude), anchor: .bottom) {
                            AnnotationMark(fishing: fishing)
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
    EF_WaterInfo(fishing: .constant(Fishing.example), water: .constant(Fishing.example.water), showMapSheet: .constant(false), cameraPosition: .constant(.automatic))
}

#Preview("Empty Fishing") {
    EF_WaterInfo(fishing: .constant(Fishing.emptyFishing), water: .constant(Fishing.emptyFishing.water), showMapSheet: .constant(false), cameraPosition: .constant(.automatic))
}
