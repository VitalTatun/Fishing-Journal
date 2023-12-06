//
//  Images.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI

struct Images: View {
    
    let fishing: Fishing
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 5) {
                ForEach(fishing.photo, id: \.self) { item in
                    if let photo = item {
                        Image(photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 50,
                                   height: 197,
                                   alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        })
    }
}

#Preview {
    Images(fishing: Fishing.example)
}
