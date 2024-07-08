//
//  EditFishingViewHeader.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct EF_HeaderView: View {
    
    @Binding var fishingName: String
    @Binding var fishingType: FishingType
    
    let paddingInsets = EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            EF_Section(title: "Название отчета", secondary: "Отметьте название и тип рыбалки")
            VStack(alignment: .leading, spacing: 5) {
                TextField("Название",text: $fishingName)
                    .textFieldStyle(OvalTextFieldStyle())
                Text("Придумайте название, например - На Карася или Смеркалось...")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Divider()
                HStack(spacing: 0) {
                    Text("Тип")
                        .foregroundColor(.secondary)
                    Spacer()
                    EF_FishingTypePicker(selection: $fishingType)
                }
            }
            
            
        }
        
        .padding(paddingInsets)
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
    EF_HeaderView(fishingName: .constant(Fishing.example.name), fishingType: .constant(Fishing.example.type))
}
