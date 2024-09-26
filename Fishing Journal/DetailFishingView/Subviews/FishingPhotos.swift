//
//  FishingPhotos.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 17.02.24.
//

import SwiftUI

struct FishingPhotos: View {
    
    let fishing: Fishing
    
    @Binding var selectedImage: UIImage?
    @Binding var showImage: Bool
    
    var animation: Namespace.ID

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(fishing.photo, id: \.self) { image in
                    if let image {
                        NavigationLink(value: image) {
                            ImageItem(item: image)
                                .matchedTransitionSource(id: image, in: animation)
                                .onTapGesture {
                                    selectedImage = image
                                    showImage = true
                                }
                        }
                    }
                }
            }
        }
    }
}

struct ImageItem: View {
    let item: UIImage
    var body: some View {
        Image(uiImage: item)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 50,
                   height: 197,
                   alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



#Preview {
    @Previewable @Namespace var preview
    FishingPhotos(fishing: Fishing.example, selectedImage: .constant(Fishing.example.photo[1]), showImage: .constant(false), animation: preview)
}
