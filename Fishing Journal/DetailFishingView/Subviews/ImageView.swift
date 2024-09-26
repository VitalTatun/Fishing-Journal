//
//  ImageView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.09.24.
//

import SwiftUI

struct ImageView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var selectedImage: UIImage?
    var animation: Namespace.ID
    
    var body: some View {
        GeometryReader { proxy in
            Color.black
            ZStack {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .navigationTransition(.zoom(sourceID: selectedImage, in: animation))
                        .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                }
            }
            .overlay(alignment: .topTrailing, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.thinMaterial)
                        .overlay {
                            Image(systemName: "xmark")
                                .foregroundStyle(Color.primaryDeepBlue)
                                .font(.headline)
                        }
                })
                .offset(x: -20, y: 100)
            })
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.example))
    }
}
