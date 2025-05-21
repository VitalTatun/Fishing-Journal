//
//  EF_CardItemConteiner.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 17.05.25.
//

import SwiftUI

struct EF_CardItemContainer<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
    }
}
