//
//  EF_SectionHeader.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 17.05.25.
//

import SwiftUI

struct EF_SectionHeader: View {
    
    let title: String
    let secondary: String
    let icon: String
    let onTap: () -> Void
    let trailingText: String? = nil
    
    var body: some View {
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
            Button(action: onTap) {
                Image(systemName: icon)
                    .fontWeight(.medium)
                    .tint(.primary)
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
    }
}
