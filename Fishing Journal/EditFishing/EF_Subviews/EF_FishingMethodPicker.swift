//
//  FishingMethodPicker.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_FishingMethodPicker: View {
    
    @Binding var selection: FishingMethod
    
    var body: some View {
        Picker("Способ ловли", selection: $selection) {
            ForEach(FishingMethod.allCases) { method in
                Text(method.nameRussian)
                    .font(.headline)
                    .tag(method)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    EF_FishingMethodPicker(selection: .constant(.feeder))
}
