//
//  FishingTypePicker.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import Foundation
import SwiftUI

struct FishingTypePicker: View {
    
    @Binding var selection: FishingType
    
    var body: some View {
        Picker("Тип", selection: $selection) {
            ForEach(FishingType.allCases) { type in
                Text(type.name)
                    .tag(type)
            }
        }
        .foregroundColor(.accentColor)
        .pickerStyle(.automatic)
    }
}

#Preview {
    FishingTypePicker(selection: .constant(.fishingLog))
}
