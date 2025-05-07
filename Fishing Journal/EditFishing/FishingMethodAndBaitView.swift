//
//  FishingMethodAndBaitView.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 7.05.25.
//

import SwiftUI

struct FishingMethodAndBaitView: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var fishingMethod: String
    @Binding var bait: String
    
    @State private var selectedMethod: String = ""
    @State private var availableBaits: [String] = []
    @State private var selectedBaits: Set<String> = [] // Используем Set для хранения выбранных наживок
    
    
    // MARK: - Способы ловли и соответствующие наживки
    let methodsAndBaits: [String: [String]] = [
        "Не указан": [],
        "Поплавок": ["Мотыль", "Опарыш", "Червь", "Перловка", "Кукуруза", "Хлеб", "Картофель", "Манка"],
        "Фидер": ["Мотыль", "Опарыш", "Червь", "Перловка", "Кукуруза", "Хлеб", "Картофель", "Манка"],
        "Спиннинг": ["Блесна", "Воблер", "Силикон", "Живец"]
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Способ ловли")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Picker("Выберите способ ловли", selection: $selectedMethod) {
                            ForEach(methodsAndBaits.keys.sorted(), id: \.self) { method in
                                Text(method).tag(method)
                                
                            }
                        }
                        .tint(.primaryDeepBlue)
                        .onTapGesture {
                            // При каждом нажатии на Picker, сбрасываем selectedMethod, чтобы при открытии Picker всегда выбрано было "Поплавок"
                            if selectedMethod.isEmpty {
                                selectedMethod = methodsAndBaits.keys.sorted().first ?? ""
                            }
                        }
                        .onChange(of: selectedMethod) { _, newMethod in
                            // Обновляем список наживок при изменении способа ловли
                            availableBaits = methodsAndBaits[newMethod] ?? []
                            // Сбрасываем выбранную наживку, чтобы пользователь выбрал новую из списка
                            selectedBaits.removeAll()
                            bait = ""
                            fishingMethod = newMethod
                            print(newMethod)
                        }
                    }
                    .frame(height: 44)
                    .padding(.horizontal, 10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(.quaternaryLabel))
                    }
                    // Список для выбора наживки (отображается условно)
                    if !availableBaits.isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(availableBaits, id: \.self) { currentBait in
                                HStack(spacing: 16) {
                                    // Отображаем галочку, если это выбранная наживка
                                    if selectedBaits.contains(currentBait) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.primaryDeepBlue)
                                            .font(.body)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundStyle(.primaryDeepBlue)
                                            .font(.body)
                                    }
                                    Text(currentBait)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .fontDesign(.rounded)
                                    Spacer()
                                }
                                .frame(height: 44)
                                .onTapGesture {
                                    // При выборе элемента, добавляем/удаляем наживку из Set
                                    if selectedBaits.contains(currentBait) {
                                        selectedBaits.remove(currentBait)
                                    } else {
                                        selectedBaits.insert(currentBait)
                                    }
                                    // Обновляем привязку bait для отображения изменений
                                    bait = Array(selectedBaits).joined(separator: ", ")
                                }
                                Divider()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 16)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color(.quaternaryLabel))
                        }
                    } else {
                        Text("Выберите способ ловли, чтобы увидеть доступные наживки.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(10)
            }
            .onAppear{
                if selectedMethod.isEmpty{
                    selectedMethod = methodsAndBaits.keys.sorted().first ?? ""
                    availableBaits = methodsAndBaits[selectedMethod] ?? []
                }
            }
        }
        .navigationTitle("Способ ловли и наживка")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Готово") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FishingMethodAndBaitView(fishingMethod: .constant(""), bait: .constant(""))
}
