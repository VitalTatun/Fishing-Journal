//
//  EF_Header.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 18.05.25.
//

import SwiftUI

struct EF_Header: View {
    
    @Binding var name: String
    
    private var statusColor: Color {
        return Color(name.isEmpty ? .red : .green)
    }
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            TextField("", text: $name, prompt: Text("Название рыбалки"))
                .fontWeight(.medium)
                .textFieldStyle(.plain)
                .frame(height: 44)
            Button {
                
                // Show Tip about fishing naming with text - Придумайте название, например - На Карася или Смеркалось...
            } label: {
                Image(systemName: "info.circle")
                    .font(.body)
                    .foregroundStyle(.blue)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 10))
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.quaternaryLabel))
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(statusColor)
                .offset(x: 6, y: 6)
                .frame(width: 6, height: 6)
        }
    }
}

#Preview {
    EF_Header(name: .constant(Fishing.example.name))
}
