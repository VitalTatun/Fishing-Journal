//
//  BaitPicker.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 28.02.24.
//

import SwiftUI

struct EF_BaitPicker: View {
    @Binding var selection: Bait
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Bait.allCases) { bait in
                Text(bait.nameRussian)
                    .tag(bait)
            }
        }
        .tint(.primaryDeepBlue)
        .pickerStyle(.automatic)
    }
}

#Preview {
    EF_BaitPicker(selection: .constant(.worm))
}
