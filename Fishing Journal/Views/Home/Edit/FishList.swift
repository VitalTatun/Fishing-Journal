//
//  FishList.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 13.05.25.
//

import SwiftUI

struct FishList: View {
    @State var viewModel: FishListViewModel
    
    let shadowColor = Color(white: 0, opacity: 0.05)

    private var alertText: String {
        if viewModel.fishingType == .haul && viewModel.fishToEditList.count >= 1 {
            return "Для трофейной рыбалки можно добавить только одну рыбу."
        }
        return "Эта рыба уже есть в списке. Просто отредактируйте количество."
        
    }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach($viewModel.fishToEditList, id: \.id) { $fish in
                HStack(alignment: .center, spacing: 10) {
                    Text("\(fish.name)")
                        .padding(.vertical, 11)
                    Spacer()
                    CustomStepper(number: $fish.count, fishList: $viewModel.fishToEditList, fish: $fish)
                }
                Divider()
            }
            .padding(.horizontal, 16)
            HStack(spacing: 10) {
                TextField("Название рыбы", text: $viewModel.newFish)
                    .font(.body)
                    .padding(.vertical, 11)
                Spacer()
                Button {
                    viewModel.checkTheSameFishInList()
                } label: {
                    Image(systemName: "plus")
                        .font(.callout)
                }
                .frame(width: 28, height: 28, alignment: .center)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .disabled(viewModel.newFish.isEmpty)

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
        .alert("Ой", isPresented: $viewModel.showAlert) {
            Button("Ок", role: .cancel) {
                viewModel.newFish = ""
            }
        } message: {
            Text(
                viewModel.fishingType == .haul && viewModel.fishToEditList.count >= 1
                ? "Для трофейной рыбалки можно добавить только одну рыбу."
                : alertText
            )
        }
    }
}

#Preview {
    NavigationStack {
        FishEditView(fish: .constant(Fishing.example.fish), fishingType: Fishing.example.type)
    }
}
