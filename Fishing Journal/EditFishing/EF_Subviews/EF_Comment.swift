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
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                section(title: sectionTitle, secondary: secondarySection)
            }
            Divider()
            if !comment.isEmpty {
                    Text(comment)
                    .padding(8)
            }
        }
        .padding(0)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
    }
    
    @ViewBuilder
    func section(title: String, secondary: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(secondary)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: {
                showCommentView.toggle()
            }, label: {
                Image(systemName: icon)
                    .fontWeight(.medium)
                    .tint(.primary)
            })
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
    }
}

#Preview {
    EF_Comment(comment: .constant("Для рыбалки замешал три пачки корма: Ультра Лещ, Река Биг Фиш и Карп Кукуруза, в последствии пожалел, что не остановился на двух пачках.то не остановился на двух пачках.то не остановился на двух пачках."), showCommentView: .constant(false))
}
