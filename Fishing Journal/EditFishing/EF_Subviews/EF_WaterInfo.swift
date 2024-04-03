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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Информация о водоеме")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            TextField("Напишите сюда название водоема",text: $water.waterName)
                .textFieldStyle(OvalTextFieldStyle())
            Text("Напишите название водоема или тип, например - река, озеро и т.д. Можно также добавить соседний населенный пункт.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Divider()
            HStack(spacing: 2) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Координаты")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Text(String(format: "%.5f", water.latitude) + " - " + String(format: "%.5f", water.longitude))
                        .font(.footnote)
                        .foregroundColor(.primaryDeepBlue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
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
            }
            
            
            Map(position: $cameraPosition) {
                Annotation(water.waterName, coordinate: .init(latitude: water.latitude, longitude: water.longitude), anchor: .bottom) {
                    AnnotationMark(fishing: fishing)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(height: 157)
            .disabled(true)
            Text("Нажмите чтобы указать место ловли. Необязательно указывать точное место, можно просто указать водоем.")
                .font(.footnote)
                .foregroundColor(.secondary)
            
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
