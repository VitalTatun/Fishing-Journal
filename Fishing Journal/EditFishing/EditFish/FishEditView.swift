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
    
    @StateObject private var fishListViewModel: FishListViewModel
    
    @State private var fishToEditList: [Fish] = []
    @State private var newFish: String = ""
    @State private var showAlert: Bool = false

    init(fish: Binding<[Fish]>, fishingType: FishingType) {
        self._fish = fish
        self._fishListViewModel = StateObject(wrappedValue: FishListViewModel(fish: fish.wrappedValue, fishingType: fishingType))
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 1).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10){
                FishList(viewModel: fishListViewModel)
                    
                EF_UserFishView(userFishCollection: userFishCollection, didChangeSelection: { selectedFish in
                    fishListViewModel.addFishFromTemplate(selectedFish)
                })
            }
            .padding(10)
        }
        .navigationTitle("Пойманная рыба")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction) {
                Button("Готово") {
                    fish = fishListViewModel.fishToEditList
                    dismiss()
                }
                .disabled(fishListViewModel.fishToEditList.isEmpty)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    dismiss()
                }
            }
        })
    }
    func checkTheSameFish(with selectedFish: Fish) {
        if fishListViewModel.fishToEditList.contains(where: { $0.name == selectedFish.name }) {

        } else {
            withAnimation(.bouncy) {
                fishListViewModel.fishToEditList.append(selectedFish)
            }
        }
    }
}


#Preview {
    NavigationStack {
        FishEditView(fish: .constant(Fishing.example.fish), fishingType: Fishing.example.type)
    }
}
