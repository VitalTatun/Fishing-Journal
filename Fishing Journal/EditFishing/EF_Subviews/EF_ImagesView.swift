//
//  EditFishingViewImages.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI
import PhotosUI

struct EF_ImagesView: View {
    
    @Binding var images: [UIImage?]
    @Binding var selectedItem: UIImage?
    
    @State private var isSelected = false
    @State private var pickerItem: [PhotosPickerItem] = []
    @State private var showPickerPhoto = false
    
    let maxCount = 6
    private let sectionTitle: String = "Фотографии"
    private let sectionSecondary: String = "Добавьте фотографии"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                EF_Section(title: sectionTitle, secondary: sectionSecondary)
                Spacer()
                if !images.isEmpty {
                    Text("\(images.count)/6")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .foregroundStyle(.primaryDeepBlue)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                CircleButton(icon: "plus") {
                    showPickerPhoto.toggle()
                }
                .disabled(images.count >= maxCount)
                .photosPicker(isPresented: $showPickerPhoto, selection: $pickerItem, maxSelectionCount: maxCount - images.count, selectionBehavior: .ordered, matching: .images, preferredItemEncoding: .automatic)
                .onChange(of: pickerItem) { _, _ in
                        Task {
                            for item in pickerItem {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        if images.count <= 5 {
                                            images.append(image)
                                            selectedItem = nil
                                        }
                                    }
                                }
                            }
                            pickerItem = []
                        }
                }
            }
            if !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(images, id: \.self) { item in
                            if let photo = item {
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100,
                                           height: 100,
                                           alignment: .leading)
                                    .clipShape(RoundedRectangle(cornerRadius: selectedItem == photo ? 5 : 10))
                                    .scaleEffect(selectedItem == photo ? 0.88 : 1)
                                    .overlay {
                                        if selectedItem == photo {
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 2)
                                                .stroke(Color.blue, lineWidth: 4)
                                                .frame(width: 100, height: 100, alignment: .center)
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            if selectedItem == nil  {
                                                selectedItem = photo
                                                isSelected = true
                                            } else if selectedItem != nil && selectedItem != photo {
                                                selectedItem = photo
                                                isSelected = true
                                            } else {
                                                selectedItem = nil
                                                isSelected = false
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                    Button {
                        withAnimation {
                            if let index = images.firstIndex(where: { $0 == selectedItem }) {
                                images.remove(at: (index))
                                isSelected = false
                            }
                        }
                    } label: {
                        Text("Удалить")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(5)
                    }
                    .disabled(!isSelected)
                    .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 0.18))
        }
        
    }
}

#Preview {
    EditFishingView(fishing: .constant(Fishing.example), showEditView: .constant(false))
}
