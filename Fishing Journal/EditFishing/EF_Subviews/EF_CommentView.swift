//
//  EF_CommentView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_CommentView: View {
    
    @Binding var fishing: Fishing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            EF_Section(title: "Комментарий", secondary: "Отредактируйте комментарий")
            TextField(
                "Добавьте детальное описание",
                text: $fishing.comment,
                axis: .vertical)
                .textFieldStyle(OvalTextFieldStyle())
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EF_CommentView(fishing: .constant(Fishing.example))
}
