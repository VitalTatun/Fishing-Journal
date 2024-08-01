//
//  UnavailableView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 10.07.24.
//

import SwiftUI

struct UnavailableView: View {
    
    @Binding var showNewFishingView: Bool
    var titleLabel: some View {
        Text("Добавить отчет")
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(.primaryDeepBlue)
    }
    
    var imageView: some View {
        Image(systemName: "plus")
            .font(.body)
            .fontWeight(.medium)
            .frame(width: 28, height: 28, alignment: .center)
            .background(.primaryDeepBlue)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
    
    var body: some View {
        ContentUnavailableView {
            VStack {
                Image("EmptyViewImagePlaceholder")
                Text("Вы пока не сохраняли отчеты")
                    .font(.title2)
                    .foregroundStyle(.primaryDeepBlue)
                    .fontWeight(.bold)
                
            }
        } description: {
            Text("Возможно сегодня именно тот день, когда стоит съездить на рыбалку")
        } actions: {
            Button(action: {
                showNewFishingView = true
            }, label: {
                HStack {
                    titleLabel
                    imageView
                }
                .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 4))
                .background(.lightBlue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Color(red: 182/255, green: 192/255, blue: 229/255))
                }
            })
        }
    }
}

#Preview {
    UnavailableView(showNewFishingView: .constant(false))
}
