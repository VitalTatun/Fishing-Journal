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
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .foregroundColor(.black)
                    HStack(spacing:10 ){
                        if let userName = fishing.user.name{
                            Text(userName)
                        }
                        Text(fishing.user.nickName)
                    }
                }
                Spacer()
                Text(fishing.type.name)
                    .font(.footnote)
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
//            Caught fishes
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(fishing.fish, id: \.id) { fish in
                        HStack {
                            Text(fish.name)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Text("\(fish.count)")
                                .font(.callout)
                                .fontWeight(.medium)
                                .padding(5)
                                .frame(width: 30, height: 30, alignment: .center)
                                .background(.white)
                                .foregroundStyle(.primaryDeepBlue)
                                .clipShape(Circle())
                        }
                        .frame(height: 36)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 3))
                        .background(.primaryDeepBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
            }
        }
    }
}

#Preview {
    Header(fishing: Fishing.example)
}
