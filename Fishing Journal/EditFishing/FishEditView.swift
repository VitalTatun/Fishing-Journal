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
    
    var userFishCollection: [Fish] = [
        Fish(name: "Карась", count: 1),
        Fish(name: "Плотва", count: 1),
        Fish(name: "Окунь", count: 1),
        Fish(name: "Подлещик", count: 1),
        Fish(name: "Щука", count: 1),
        Fish(name: "Пескарь", count: 1),
        Fish(name: "Лещ", count: 1)
    ]
    
    @State private var fishToEditList: [Fish] = []
    @State private var newFish: String = ""
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 1).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10){
                FishList(fishToEditList: $fishToEditList)
                    
                EF_UserFishView(userFishCollection: userFishCollection, didChangeSelection: { selectedFish in
                    checkTheSameFish(with: selectedFish)
                })
            }
            .padding(10)
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
    func checkTheSameFish(with selectedFish: Fish) {
        if fishToEditList.contains(where: { $0.name == selectedFish.name }) {

        } else {
            withAnimation(.bouncy(duration: 0.3)) {
                fishToEditList.append(selectedFish)
            }
        }
    }
}

struct FishList: View {
    @Binding var fishToEditList: [Fish]
    
    @State private var showAlert: Bool = false
    @State private var newFish: String = ""
    
    let shadowColor = Color(white: 0, opacity: 0.05)

    private var alertText: String {
        return "\(newFish) уже есть в списке. Просто отредактируйте количество."
        
    }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach($fishToEditList, id: \.id) { $fish in
                HStack(alignment: .center, spacing: 10) {
                    Text("\(fish.name)")
                        .padding(.vertical, 11)
                    Spacer()
                    CustomStepper(number: $fish.count, fishList: $fishToEditList, fish: $fish)
                }
                Divider()
            }
            .padding(.horizontal, 16)
            HStack(spacing: 10) {
                TextField("Название рыбы", text: $newFish)
                    .font(.body)
                    .padding(.vertical, 11)
                Spacer()
                Button {
                    checkTheSameFishInList()
                } label: {
                    Image(systemName: "plus")
                        .font(.callout)
                }
                .frame(width: 28, height: 28, alignment: .center)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .disabled(newFish.isEmpty)

            }
            .padding(.horizontal, 16)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
        .shadow(color: shadowColor, radius: 6, x: 0, y: 2)
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
