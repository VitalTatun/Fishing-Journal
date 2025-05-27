//
//  EF_Header.swift
//  Fishing Journal
//
//  Created by Vital Tatun on 18.05.25.
//

import SwiftUI

struct EF_Header: View {
    
    @Binding var name: String
    @Binding var type: FishingType
    
    private var statusColor: Color {
        return Color(name.isEmpty ? .red : .green)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
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
            Divider()
            HStack(alignment: .center, spacing: 10) {
                Text("Тип рыбалки")
                Spacer()
                EF_FishingTypePicker(selection: $type)
            }
            .frame(height: 44)
        }
        .rounderBorderedModifier()
        .overlay(alignment: .topLeading) {
            Circle()
                .foregroundStyle(statusColor)
                .offset(x: 6, y: 6)
                .frame(width: 6, height: 6)
        }
    }
}

struct RoundedBordered: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 10))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(.quaternaryLabel))
            }
    }
}
extension View {
    func rounderBorderedModifier() -> some View {
        modifier(RoundedBordered())
    }
}

#Preview {
    EF_Header(name: .constant(Fishing.example.name), type: .constant(Fishing.example.type))
}
