//
//  SmalLabelComponent.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 28/06/25.
//

import SwiftUI

struct SmalLabelComponent: View {
    @ScaledMetric private var scale: CGFloat = 1
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
        HStack(spacing: 6) {
            Image(.shovel)
                .resizable()
                .frame(width: 20 * scale, height: 20 * scale)
                .padding(.bottom, 2)
            
            Text(text)
                .monospacedDigit()
                .multilineTextAlignment(.center)
                .font(.escavatorUI(.body1Regular))
                .foregroundStyle(.white)
        }
        .padding(.vertical, 2)
        .padding(.horizontal, 10)
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
    SmalLabelComponent(text: "1/4", colorType: .green)
}
