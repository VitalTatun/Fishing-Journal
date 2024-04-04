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
    @State private var fishToEdit: [Fish] = []
    @State private var textFieldText: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            ForEach($fishToEdit, id: \.id) { $fish in
                HStack {
                    Text("\(fish.name)")
                    Spacer()
                    CustomStepper(number: $fish.count)
                }
                .padding(.vertical, 0)
            }
            .onDelete { indexSet in
                fishToEdit.remove(atOffsets: indexSet)
            }
            HStack {
                TextField("Название", text: $textFieldText)
                Button(action: {
                    if fishToEdit.contains(where: { $0.name == textFieldText }) {
                        showAlert = true
                    } else {
                        withAnimation(.easeIn) {
                            addNewFish(text: textFieldText)
                        }
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                })
                .buttonStyle(.borderless)
                .disabled(textFieldText.isEmpty)
            }
            
        }
        .onAppear {
            fishToEdit = fish
        }
        .alert("Упс", isPresented: $showAlert, actions: {
            Button("Ок") {
                    textFieldText = ""
            }
        }, message: {
            Text("Эта рыба уже есть в списке. Просто отредактируйте количество.")
        })
        .listStyle(.automatic)
        .navigationTitle("Пойманная рыба")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    fish = fishToEdit
                    dismiss()
                }
                .disabled(fishToEdit.isEmpty)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    dismiss()
                }
            }
        })
    }
    
    private func addNewFish(text: String) {
        let newFish = Fish(name: text, count: 1)
        fishToEdit.append(newFish)
        self.textFieldText = ""
    }
}

#Preview {
    FishEditView(fish: .constant(Fishing.example.fish))
}
