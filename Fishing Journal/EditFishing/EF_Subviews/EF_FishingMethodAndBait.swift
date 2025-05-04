//
//  EF_FishingMethodAndBait.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 4.05.25.
//

import SwiftUI

struct EF_FishingMethodAndBait: View {
    
    private let sectionTitle: String = "Способ ловли и наживка"
    private let sectionSecondary: String = "Отредактируйте список наживки"

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            section(title: sectionTitle, secondary: sectionSecondary)
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
func section(title: String, secondary: String) -> some View {
    HStack(alignment: .center, spacing: 10) {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(secondary)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        Spacer()
        Button(action: {
            
        }, label: {
            Image(systemName: "chevron.right")
                .fontWeight(.medium)
                .tint(.primary)
        })
    }
    .frame(height: 60)
    .padding(.horizontal, 16)
}

#Preview {
    EF_FishingMethodAndBait()
}
