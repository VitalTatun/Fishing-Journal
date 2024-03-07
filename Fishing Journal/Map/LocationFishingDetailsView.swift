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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $showImageView)
                    FishCaught(fishing: $fishing)
                    FishingInfo(fishing: fishing)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(fishing.water.waterName)
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.black)
                                Text(String(fishing.water.latitude) + " • " + String(fishing.water.longitude))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
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
                            }
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
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(fishing.name)
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        Text(fishing.user.name)
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    .layoutPriority(2)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text(fishing.type.name)
                            .font(.footnote)
                            .lineLimit(1)
                            .fontWeight(.medium)
                            .foregroundStyle(fishing.type.accentColor)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(fishing.type.backgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(fishing.type.accentColor)
                            }
                            .layoutPriority(1)
                        Button {
                            favorite.toggle()
                        } label: {
                            Image(systemName: favorite ? "bookmark.fill" : "bookmark")
                                .font(.callout)
                                .foregroundStyle(favorite ? .red : .primaryDeepBlue)
                        }
                        
                    }
                }
                
//                ToolbarItem(placement: .principal) {
//                        VStack(alignment: .leading, spacing: 0) {
//                            Text(fishing.name)
//                                .font(.system(.headline, design: .rounded, weight: .semibold))
//                                .foregroundColor(.black)
//                                .lineLimit(1)
//                            Text(fishing.user.name)
//                                .font(.footnote)
//                                .lineLimit(1)
//                        }
//                }
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
