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
    
    private var icon: String {
        if comment.isEmpty {
            return "plus"
        } else {
            return "square.and.pencil"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                EF_Section(title: "Комментарий", secondary: "Отредактируйте комментарий")
                Spacer()
                CircleButton(icon: icon) {
                    showCommentView.toggle()
                }
            }
            if !comment.isEmpty {
                    Text(comment)
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 0.18))
        }
    }
}

#Preview {
    EF_Comment(comment: .constant("Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках.то не остановился на двух пачках.то не остановился на двух пачках."), showCommentView: .constant(false))
}
