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
    @State private var text: String = ""
    
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
                fish.remove(atOffsets: indexSet)
            }
            HStack {
                TextField("Название", text: $text)
                Button(action: {
                    withAnimation(.easeIn) {
                        addNewFish(text: text)
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                })
                .buttonStyle(.borderless)
                .disabled(text.isEmpty)
            }
        }
        .onAppear {
            fishToEdit = fish
        }
        .listStyle(.automatic)
        .navigationTitle("Пойманная рыба")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    fish = fishToEdit
                    dismiss()
                }
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
        self.text = ""
    }
}

#Preview {
    FishEditView(fish: .constant(Fishing.example.fish))
}
