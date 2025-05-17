//
//  EditFishingViewImages.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI
import PhotosUI

struct EF_ImagesView: View {
    
    @ObservedObject var viewModel: EditFishingViewModel
    
    @State private var isSelected = false
    @State private var pickerItem: [PhotosPickerItem] = []
    @State private var showPickerPhoto = false
    
    let maxCount = 6
    private let sectionTitle: String = "Фотографии"
    private let sectionSecondary: String = "Добавьте фотографии"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(sectionTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(sectionSecondary)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if !viewModel.images.isEmpty {
                    Text("\(viewModel.images.count)/6")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .foregroundStyle(.primaryDeepBlue)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Button(action: {
                    showPickerPhoto.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .fontWeight(.medium)
                        .tint(.primary)
                })
                .buttonStyle(.borderless)
                .disabled(viewModel.images.count >= maxCount)
                .photosPicker(isPresented: $showPickerPhoto, selection: $pickerItem, maxSelectionCount: maxCount - viewModel.images.count, selectionBehavior: .ordered, matching: .images, preferredItemEncoding: .automatic)
                .onChange(of: pickerItem) {
                        Task {
                            await viewModel.addImages(from: pickerItem)
                            pickerItem = []
                        }
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 16)

            if !viewModel.images.isEmpty {
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(viewModel.images, id: \.self) { item in
                            if let photo = item {
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100,
                                           height: 100,
                                           alignment: .leading)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .overlay (alignment: .topTrailing) {
                                        Button {
                                            withAnimation {
                                                viewModel.removeImage(photo)
                                            }
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.title2)
                                                .frame(width: 30, height: 30)
                                                .foregroundStyle(.thinMaterial)
                                                .shadow(radius: 2)
                                        }
                                    }
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(4)
            }
        }
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
    }
}

#Preview {
    EF_ImagesView(viewModel: EditFishingViewModel(fishing: Fishing.example))
}
