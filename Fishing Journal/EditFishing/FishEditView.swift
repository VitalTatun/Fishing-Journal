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
    
    let shadowColor = Color(white: 0, opacity: 0.05)
        
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 1).ignoresSafeArea()
            VStack(alignment: .leading){
                FishList(fishToEditList: $fishToEditList)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(.quaternaryLabel))
                    }
                    .shadow(color: shadowColor, radius: 6, x: 0, y: 2)
                    .padding(10)
            }

        }
        .onAppear {
            fishToEditList = fish
        }

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
}

struct FishList: View {
    @Binding var fishToEditList: [Fish]
    
    @State private var showAlert: Bool = false
    @State private var newFish: String = ""
    
    private var alertText: String {
        return "\(newFish) уже есть в списке. Просто отредактируйте количество."

    }
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ForEach($fishToEditList, id: \.id) { $fish in
                HStack {
                    Text("\(fish.name)")
                    Spacer()
                    CustomStepper(number: $fish.count, fishList: $fishToEditList, fish: $fish)
                }
                Divider()
            }
            HStack {
                TextField("Название", text: $newFish)
                    .font(.body)
                Spacer()
                CircleButton(icon: "plus", action: {
                    checkTheSameFishInList()
                })
                .disabled(newFish.isEmpty)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .alert("Упс", isPresented: $showAlert, actions: {
            Button("Ок") {
                newFish = ""
            }
        }, message: {
            Text(alertText)
        })
    }
    
    
    private func checkTheSameFishInList() {
        if fishToEditList.contains(where: { $0.name == newFish }) {
            showAlert = true
        } else {
            withAnimation(.easeIn) {
                addNewFish(fish: newFish)
            }
        }
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
