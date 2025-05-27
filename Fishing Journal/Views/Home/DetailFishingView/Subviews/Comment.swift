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
                Text(fishing.comment)
                    .font(.callout)
            }
        }
    }
}

#Preview {
    Comment(fishing: Fishing.example)
}
