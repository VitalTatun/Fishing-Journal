//
//  Header.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 6.12.23.
//

import SwiftUI

struct Header: View {
    
    let fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
//            User Info
            HStack {
                Image("userExample")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(Circle())
                    
                VStack(alignment: .leading, spacing: 0) {
                    Text(fishing.name)
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(fishing.user.name)
                        .font(.footnote)
                        .lineLimit(1)
                }
                Spacer()
                Text(fishing.type.name)
                    .font(.footnote)
                    .lineLimit(1)
                    .fontWeight(.medium)
                    .foregroundStyle(fishing.type.accentColor)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(fishing.type.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(fishing.type.accentColor)
                    }
            }
        }
    }
}

#Preview {
    Header(fishing: Fishing.example)
}


