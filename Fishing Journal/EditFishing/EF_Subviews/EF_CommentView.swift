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
        VStack(alignment: .leading, spacing: 5) {
            Text("Комментарий:")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
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
