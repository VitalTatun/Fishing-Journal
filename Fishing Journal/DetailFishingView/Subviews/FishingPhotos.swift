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
    @Binding var isPresentingPhotoView: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 5) {
                ForEach(fishing.photo, id: \.self) { item in
                        if let item {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 50,
                                       height: 197,
                                       alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    selectedImage = item
                                    isPresentingPhotoView = true
                                }
                        }
                    }
            }
        })
    }
}


#Preview {
    FishingPhotos(fishing: Fishing.example, selectedImage: .constant(Fishing.example.photo[1]), isPresentingPhotoView: .constant(true))
}
