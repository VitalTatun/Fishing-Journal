//
//  EditFishingViewHeader.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import SwiftUI

struct EF_HeaderView: View {
    
    @Binding var fishing: Fishing
    @Binding var fishingName: String
    @Binding var fishingType: FishingType
    
    let paddingInsets = EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10)
    
    var body: some View {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Название отчета")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .padding(.bottom, 5)
                    Group {
                        TextField("Название",text: $fishingName)
                            .textFieldStyle(OvalTextFieldStyle())
                        Text("Придумайте название, например - На Карася или Смеркалось...")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    HStack(spacing: 0) {
                        Text("Тип")
                            .foregroundColor(.secondary)
                        Spacer()
                        EF_FishingTypePicker(selection: $fishingType)
                    }
                }
        .padding(paddingInsets)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    EF_HeaderView(fishing: .constant(Fishing.example), fishingName: .constant(Fishing.example.name), fishingType: .constant(Fishing.example.type))
}
