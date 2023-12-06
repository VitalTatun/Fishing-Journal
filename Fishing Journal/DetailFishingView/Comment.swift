//
//  Comment.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI

struct Comment: View {
    
    let fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !fishing.comment.isEmpty {
                Text("Комментарий")
                    .font(.headline)
                    .foregroundColor(.primaryDeepBlue)
                Text(fishing.comment)
                    .font(.callout)
                    .padding(.vertical,10)
            }
        }
        .padding(10)
    }
}

#Preview {
    Comment(fishing: Fishing.example)
}
