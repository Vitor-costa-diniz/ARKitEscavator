//
//  LargeLabelComponent.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

enum ColorType {
    case blue
    case green
}

struct LargeLabelComponent: View {
    let text: String
    let colorType: ColorType
    
    private var background: Color {
        switch colorType {
        case .blue:
                .blueBackground
        case .green:
                .greenBackground
        }
    }
    
    private var stroke: Color {
        switch colorType {
        case .blue:
                .blueStroke
        case .green:
                .greenStroke
        }
    }
    
    private var shadow: Color {
        switch colorType {
        case .blue:
                .blueShadow
        case .green:
                .greenShadow
        }
    }
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 309)
            .frame(minHeight: 69)
            .font(.escavatorUI(.body1Regular))
            .foregroundStyle(.white)
            .padding(.horizontal, 13)
            .background {
                LabelShape()
                    .foregroundStyle(shadow)
                    .offset(y: 2.5)
                
                LabelShape()
                    .foregroundStyle(stroke)
                    .overlay {
                        LabelShape()
                            .foregroundStyle(background)
                            .padding(2.5)
                    }
            }
    }
}

#Preview {
    LargeLabelComponent(text: "Procure o ponto de escavação!", colorType: .blue)
}
