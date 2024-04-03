//
//  EF_Comment.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.04.24.
//

import SwiftUI

struct EF_Comment: View {
    
    @Binding var comment: String
    @Binding var showCommentView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                EF_Section(title: "Комментарий", secondary: "Отредактируйте комментарий")
                Spacer()
                Button {
                    showCommentView.toggle()
                } label: {
                    
                    Image(systemName: comment.isEmpty ? "plus" : "square.and.pencil")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryDeepBlue)
                }
            }
            if !comment.isEmpty {
                    Text(comment)
                        .lineLimit(5)
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_Comment(comment: .constant("Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках.то не остановился на двух пачках.то не остановился на двух пачках."), showCommentView: .constant(false))
}
