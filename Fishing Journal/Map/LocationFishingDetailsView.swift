//
//  LocationFishingDetailsView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI
import MapKit

struct LocationFishingDetailsView: View {
    
    @State private var selectedImage: String?
    @State private var showImageView = false
    @State private var favorite = false
    
    @Binding var fishing: Fishing
    @Binding var showLocationDetail: Bool
    
    let format = "%.5f"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $showImageView)
                    Header(fishing: fishing)
                    FishCaught(fish: $fishing.fish)
                    FishingInfo(fishing: fishing)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(fishing.water.waterName)
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                Text(String(format: format, fishing.water.latitude) + " - " + String(format: format, fishing.water.longitude))
                                    .font(.footnote)
                                    .foregroundColor(.primaryDeepBlue)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 2)
                                    .background(.lightBlue)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            Spacer()
                            CopyButton(water: $fishing.water)
                        }
                    }
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 1)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.black.opacity(0.18))
                    }
                    Comment(fishing: fishing)
                }
                .padding(10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(fishing.name)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад") {
                        showLocationDetail = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            favorite.toggle()
                        } label: {
                            Image(systemName: favorite ? "bookmark.fill" : "bookmark")
                                .font(.callout)
                                .foregroundStyle(favorite ? .red : .primaryDeepBlue)
                        }
                }
            })
            .scrollIndicators(.hidden)
            .fullScreenCover(isPresented: $showImageView, content: {
                NavigationStack {
                    PhotoView(fishing: fishing, selectedImage: $selectedImage)
                }
            })
            
        }

    }
    
}


#Preview {
    LocationFishingDetailsView(fishing: .constant(Fishing.example), showLocationDetail: .constant(false))
}
