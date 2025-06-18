//
//  LargeLabelComponent.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

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
            .font(.escavatorUI(.body1Regular))
            .foregroundStyle(.white)
            .padding(.top, 5)
            .padding(.bottom, 3)
            .padding(.horizontal, 8)
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
    LargeLabelComponent(text: "Olaaa", colorType: .green)
}

enum ColorType {
    case blue
    case green
}
