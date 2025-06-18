//
//  LabelComponent.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct LabelComponent: View {
    let text: String
    let font: Font
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(.buttonIcon)
            .padding(.top, 5)
            .padding(.bottom, 3)
            .padding(.horizontal, 8)
            .background {
                LabelShape()
                    .foregroundStyle(.buttonShadow)
                    .offset(y: 2.5)
                
                LabelShape()
                    .foregroundStyle(.buttonStroke)
                    .overlay {
                        LabelShape()
                            .foregroundStyle(.buttonOverlay)
                            .padding(2.5)
                    }
            }
    }
}

#Preview {
    LabelComponent(text: "Fortaleza - CE", font: .escavatorUI(.body2Regular))
}
