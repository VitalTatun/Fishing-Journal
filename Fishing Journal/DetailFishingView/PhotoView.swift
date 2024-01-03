//
//  PhotoView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 18.12.23.
//

import SwiftUI

struct PhotoView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isSelectedImage = false
    
    @State private var zoomScale: CGFloat = 1
    @State private var previousZoomScale: CGFloat = 1
    
    private let minZoomScale: CGFloat = 1.0
    private let maxZoomScale: CGFloat = 3.0
    
    @State private var location: CGPoint = .zero
    
    let fishing: Fishing
    
    @Binding var selectedImage: String?
    
    var body: some View {
        NavigationStack {
                GeometryReader { geometry in
                    VStack {
                        ScrollView([.horizontal, .vertical], showsIndicators: false) {
                            if let photo = selectedImage {
                                Image(photo)
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(max(previousZoomScale, 1))
                                    .frame(width: geometry.size.width * zoomScale)
                                    .highPriorityGesture(
                                        MagnificationGesture()
                                            .onChanged(onZoomGestureStarted)
                                            .onEnded(onZoomGestureEnded)
                                    )
                                    .onTapGesture(count: 2) {
                                        if zoomScale == minZoomScale {
                                            withAnimation(.bouncy) {
                                                zoomScale = 3
                                            }
                                        } else {
                                            withAnimation(.bouncy) {
                                                zoomScale = 1.0
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(.ultraThinMaterial)
                        ScrollView(.horizontal) {
                            HStack(alignment: .center, spacing: 5) {
                                ForEach(fishing.photo, id: \.self) { image in
                                    if let photo = image {
                                        Image(photo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: selectedImage == photo ? 60 : 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .onTapGesture {
                                                withAnimation {
                                                    isSelectedImage = true
                                                    selectedImage = photo
                                                    zoomScale = 1
                                                }
                                            }
                                        
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .ignoresSafeArea()
                .overlay(alignment: .topLeading, content: {
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
                    .offset(x: 10.0, y: 10.0)
                })
                .background(Color.black)

        }
    }
}

extension PhotoView {
    
    func onZoomGestureStarted(value: MagnificationGesture.Value) {
        withAnimation {
            let delta = value / previousZoomScale
            previousZoomScale = value
            let zoomDelta = zoomScale * delta
            var minMaxScale = max(minZoomScale, zoomDelta)
            minMaxScale = min(maxZoomScale, minMaxScale)
            zoomScale = minMaxScale
        }
    }
    
    func onZoomGestureEnded(value: MagnificationGesture.Value) {
        withAnimation {
            previousZoomScale = 1
            if zoomScale <= 1 {
                zoomScale = 1
            } else if zoomScale > 5 {
                zoomScale = 5
            }
        }
    }
    
    func onDoubleTapGesture(geoProxy: GeometryProxy) {
        if zoomScale == minZoomScale {
            withAnimation(.bouncy) {
                zoomScale = maxZoomScale
            }
        } else {
            withAnimation(.bouncy) {
                zoomScale = 1.0
            }
        }
    }
}

#Preview {
    PhotoView(fishing: Fishing.example, selectedImage: .constant("7"))
}
