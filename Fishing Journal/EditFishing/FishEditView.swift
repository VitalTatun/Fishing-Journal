//
//  FishEditView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct FishEditView: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var fish: [Fish]
    @State private var fishToEditList: [Fish] = []
    @State private var newFish: String = ""
    @State private var showAlert: Bool = false
    
    private let alertText: String = "Эта рыба уже есть в списке. Просто отредактируйте количество."
    
    var body: some View {
        List {
            ForEach($fishToEditList, id: \.id) { $fish in
                HStack {
                    Text("\(fish.name)")
                    Spacer()
                    CustomStepper(number: $fish.count)
                }
                .padding(.vertical, 0)
            }
            .onDelete { indexSet in
                fishToEditList.remove(atOffsets: indexSet)
            }
            HStack {
                TextField("Название", text: $newFish)
                Button(action: {
                    if fishToEditList.contains(where: { $0.name == newFish }) {
                        showAlert = true
                    } else {
                        withAnimation(.easeIn) {
                            addNewFish(fish: newFish)
                        }
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
                .buttonStyle(.borderless)
                .disabled(newFish.isEmpty)
            }
            
        }
        .onAppear {
            fishToEditList = fish
        }
        .alert("Упс", isPresented: $showAlert, actions: {
            Button("Ок") {
                    newFish = ""
            }
        }, message: {
            Text(alertText)
        })
        .listStyle(.automatic)
        .navigationTitle("Пойманная рыба")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    fish = fishToEditList
                    dismiss()
                }
                .disabled(fishToEditList.isEmpty)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    dismiss()
                }
            }
        })
    }
    
    private func addNewFish(fish: String) {
        let newFish = Fish(name: fish, count: 1)
        fishToEditList.append(newFish)
        self.newFish = ""
    }
}

#Preview {
    FishEditView(fish: .constant(Fishing.example.fish))
}
