//
//  EF_Section.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.04.24.
//

import SwiftUI

struct EF_Section: View {
    
    let title: String
    let secondary: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text(secondary)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    EF_Section(title: "Название отчета", secondary: "Отметьте название и тип рыбалки")
}
