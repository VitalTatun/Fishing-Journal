//
//  CommentView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 3.04.24.
//

import SwiftUI

struct CommentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var comment: String
    @State private var newComment: String = ""
    
    var body: some View {
        NavigationStack {
            TextField(
                "Опишите подробнее рыбалку",
                text: $newComment,
                axis: .vertical)
            .padding(10)
            Spacer()
           
        }
        .onAppear {
            newComment = comment
        }
        .navigationTitle("Комментарий")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Готово") {
                    comment = newComment
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CommentView(comment: .constant(""))
    }
}
