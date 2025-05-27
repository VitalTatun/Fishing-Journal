//
//  FishingTypePicker.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.02.24.
//

import Foundation
import SwiftUI

struct EF_FishingTypePicker: View {
    
    @Binding var selection: FishingType
    
    var body: some View {
        Picker("Тип", selection: $selection) {
            ForEach(FishingType.allCases) { type in
                Text(type.name)
                    .tag(type)
            }
        }
        .pickerStyle(.automatic)
        .tint(.primaryDeepBlue)
    }
}

#Preview {
    EF_FishingTypePicker(selection: .constant(.fishingLog))
}
