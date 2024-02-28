//
//  DetailFishingView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct DetailFishingView: View {
    
    @Binding var fishing: Fishing
    
    @State private var selectedImage: String?
    @State private var isPresentingEditView = false
    @State private var isPresentingPhotoView = false
    @State private var editingFishing = Fishing.emptyFishing
    @State private var isFavorite = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FishingPhotos(fishing: fishing, selectedImage: $selectedImage, isPresentingPhotoView: $isPresentingPhotoView)
                    Header(fishing: fishing)
                    FishCaught(fishing: fishing)
                    FishingInfo(fishing: fishing)
                    WaterInfo(fishing: fishing)
                    Comment(fishing: fishing)
                }
                .padding(10)
            }
            .navigationTitle(fishing.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        .fullScreenCover(isPresented: $isPresentingPhotoView, content: {
            NavigationStack {
                PhotoView(fishing: fishing, selectedImage: $selectedImage)
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingEditView = true
                    editingFishing = fishing
                } label: {
                    Text("Изменить")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EditFishingView(fishing: $editingFishing)
                    .navigationTitle(fishing.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "bookmark")
                            })
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Отмена") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Готово") {
                                isPresentingEditView = false
                                fishing = editingFishing
                            }
                            .disabled(editingFishing.fish.isEmpty)
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailFishingView(fishing: .constant(Fishing.example))
    }
}

