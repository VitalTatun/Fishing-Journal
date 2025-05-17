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
    
    let sectionTitle = "Комментарий"
    let secondarySection = "Отредактируйте комментарий"
    
    private var icon: String {
        if comment.isEmpty {
            return "plus"
        } else {
            return "chevron.right"
        }
    }
    
    var body: some View {
        EF_CardItemContainer {
            EF_SectionHeader(
                title: sectionTitle,
                secondary: secondarySection,
                icon: icon,
                onTap: { showCommentView.toggle() }
            )
            Divider()
            if !comment.isEmpty {
                Text(comment)
                    .padding(8)
            }
        }
    }
}

#Preview {
    EF_Comment(comment: .constant("Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках.то не остановился на двух пачках.то не остановился на двух пачках."), showCommentView: .constant(false))
}
