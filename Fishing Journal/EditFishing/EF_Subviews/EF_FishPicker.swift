//
//  EditNewFishView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct EF_FishPicker: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var fishing: Fishing
    @State private var text: String = ""
    
    var body: some View {
        List {
            ForEach($fishing.fish, id: \.id) { $fish in
                HStack {
                    Text("\(fish.name)")
                    Spacer()
                    CustomStepper(number: $fish.count)
                }
                .padding(.vertical, 0)
            }
            .onDelete(perform: { indexSet in
                fishing.fish.remove(atOffsets: indexSet)
            })
            HStack {
                TextField("Название", text: $text)
                Button(action: {
                    withAnimation {
                        let fish = Fish(name: text, count: 1)
                        fishing.fish.append(fish)
                        self.text = ""
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                })
                .buttonStyle(.borderless)
                .disabled(text.isEmpty)
            }
        }
        .listStyle(.automatic)
        .navigationTitle("Пойманная рыба")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    dismiss()
                }
            }
        })
    }
}

#Preview {
    EF_FishPicker(fishing: .constant(Fishing.example))
}
