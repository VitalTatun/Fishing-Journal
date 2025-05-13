//
//  FishingMethodAndBaitSelectionView.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 12.05.25.
//

import SwiftUI

struct FishingMethodAndBaitSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: FishingViewModel
    
    var onFinish: (_ method: FishingMethod, _ bait: [Bait]) -> Void
    
    init(
        initialMethod: FishingMethod,
        initialBaits: [Bait],
        onFinish: @escaping (_ method: FishingMethod, _ bait: [Bait]) -> Void
    ) {
        self.viewModel = FishingViewModel(initialMethod: initialMethod, initialBait: initialBaits)
        self.onFinish = onFinish
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                FishingMethodPicker(selectedMethod: $viewModel.selectedMethod)
                
                if !viewModel.availableBaits.isEmpty {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.availableBaits) { bait in
                            AvailableBaitsRow(
                                selectedBaits: viewModel.selectedBaits,
                                currentBait: bait
                            )
                            .onTapGesture {
                                viewModel.toggleBait(bait)
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
                    Text("Выберите способ ловли, чтобы увидеть доступные наживки")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(10)
            .navigationTitle("Способ ловли и наживка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово") {
                        onFinish(viewModel.selectedMethod, Array(viewModel.selectedBaits))
                        dismiss()
                    }
                    .disabled(viewModel.selectedBaits.isEmpty)
                }
            }
        }
    }
}
#Preview {
    let sampleMethod: FishingMethod = .bobber
    let sampleBaits: [Bait] = [.worm, .maggot]
    
    let viewModel = FishingViewModel(
        initialMethod: sampleMethod,
        initialBait: sampleBaits
    )
    
    NavigationStack {
        FishingMethodAndBaitSelectionView(initialMethod: sampleMethod, initialBaits: sampleBaits) { method, bait in
        }
    }
}


struct AvailableBaitsRow: View {
    
    var selectedBaits: Set<Bait>
    var currentBait: Bait
    
    var body: some View {
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
            Text(currentBait.nameRussian)
                .font(.body)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            Spacer()
        }
        .frame(height: 44)
    }
}

struct FishingMethodPicker: View {
    
    @Binding var selectedMethod:FishingMethod
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Способ ловли")
                .font(.callout)
                .foregroundStyle(.secondary)
            Spacer()
            Picker("Выберите способ ловли", selection: $selectedMethod) {
                ForEach(FishingMethod.allCases) { method in
                    Text(method.nameRussian).tag(method)
                }
            }
            .tint(.primaryDeepBlue)
            
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
    }
}

