//
//  EF_FishingMethodAndBait.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 4.05.25.
//

import SwiftUI

struct EF_FishingMethodAndBait: View {
    
    @Binding var showFishingMethodAndBait: Bool
    
    private let sectionTitle: String = "Способ ловли и наживка"
    private let sectionSecondary: String = "Отредактируйте список наживки"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(sectionTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(sectionSecondary)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button(action: {
                    showFishingMethodAndBait = true
                }, label: {
                    Image(systemName: "chevron.right")
                        .fontWeight(.medium)
                        .tint(.primary)
                })
            }
            .frame(height: 60)
            .padding(.horizontal, 16)
            Divider()
            HStack(alignment: .center, spacing: 10) {
                Text("Способ ловли")
                    .font(.callout)
                Spacer()
                Text("Поплавок")
                    .font(.body)
            }
            .padding(.horizontal, 10)
            .frame(height: 44)
            Divider()
            HStack(alignment: .center, spacing: 10) {
                Text("Наживка")
                    .font(.callout)
                Spacer()
                Text("Мотыль, Опарыш")
                    .font(.body)
            }
            .padding(.horizontal, 10)
            .frame(height: 44)
        }
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(.red)
                .offset(x: 6, y: 6)
                .frame(width: 6, height: 6)
        }
    }
}
@ViewBuilder
func section(title: String, secondary: String, showScreen: Binding<Bool>) -> some View {
    
}

#Preview {
    EF_FishingMethodAndBait(showFishingMethodAndBait: .constant(false))
}
