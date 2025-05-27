//
//  SelectedImageViewer.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 26.09.24.
//

import SwiftUI

struct SelectedImageViewer: View {
    
    @Environment(\.dismiss) var dismiss
    
    let selectedImage: UIImage?
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Color.black
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .navigationTransition(.zoom(sourceID: selectedImage, in: animation))
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                    }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @Namespace var previewAnimation
    SelectedImageViewer(selectedImage: Fishing.example.photo[0], animation: previewAnimation)
}
