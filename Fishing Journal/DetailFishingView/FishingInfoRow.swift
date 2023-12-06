//
//  FishingInfoRow.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI

struct FishingInfoRow: View {
    var name: String
    var element: String
    var secondary: String?
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(name)
                .foregroundColor(.secondary)
            Spacer()
            VStack(alignment: .trailing) {
                Text(element)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.black)
                if let sec = secondary {
                    Text(sec)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FishingInfoRow(name: "", element: "")
}
