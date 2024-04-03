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
    @Binding var showOnMap: Bool
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(fishing.water.waterName)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.black)
                    Text(String(format: "%.5f", fishing.water.latitude) + " • " + String(format: "%.5f", fishing.water.longitude))
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
                    let coordinates = String(format: "%.5f", fishing.water.latitude) + " " + String(format: "%.5f", fishing.water.longitude)
                    pasteboard.string = coordinates
                } label: {
                    Image(systemName: "square.on.square")
                        .foregroundStyle(.primaryDeepBlue)
                        .frame(width: 34, height: 34, alignment: .center)
                        .background(.lightBlue)
                        .clipShape(Circle())
                }
            }

            Map(position: $cameraPosition) {
                Annotation(fishing.name, coordinate: .init(latitude: fishing.water.latitude, longitude: fishing.water.longitude), anchor: .bottom) {
                    AnnotationMark(fishing: fishing)
                }
            }
            .onChange(of: fishing.water.id, {
                cameraPosition = .updateCameraPosition(fishing: fishing)
            })
            .onAppear(perform: {
                cameraPosition = .updateCameraPosition(fishing: fishing)
            })
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(height: 157)
            .disabled(true)
            Button {
                showOnMap.toggle()
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
    WaterInfo(fishing: Fishing.example, showOnMap: .constant(false))
}

