//
//  AnnotationMark.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 22.02.24.
//

import SwiftUI

struct AnnotationMark: View {
    
    let fishing: Fishing
    @Binding var active: Bool
    
    var body: some View {
        ZStack {
            Image(fishing.type.annotationMark)
            Image(fishing.fishingMethod.icon)
                .offset(y: -8)

        }
    }
}

#Preview {
    AnnotationMark(fishing: Fishing.example, active: .constant(false))
}
