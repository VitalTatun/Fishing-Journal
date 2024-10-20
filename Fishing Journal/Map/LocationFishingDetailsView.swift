//
//  LocationFishingDetailsView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI
import MapKit

struct LocationFishingDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let fishing: Fishing
    
    @State private var selectedImage: UIImage?
    @State private var showPhotoView = false
    @State private var favorite = false
    
    @Namespace private var animation
    
    let format = "%.5f"
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(fishing.photo, id: \.self) { image in
                                NavigationLink(value: image) {
                                    if let image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width - 50,
                                                   height: 197,
                                                   alignment: .leading)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .matchedTransitionSource(id: image, in: animation)
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(for: UIImage.self) { image in
                        SelectedImageViewer(selectedImage: image, animation: animation)
                    }
                    Header(fishing: fishing)
                    FishCaught(fish: fishing.fish)
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
                            CopyButton(water: fishing.water)
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
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Назад") {
                    dismiss()
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

    }
}


#Preview {
    LocationFishingDetailsView(fishing: Fishing.example)
}
