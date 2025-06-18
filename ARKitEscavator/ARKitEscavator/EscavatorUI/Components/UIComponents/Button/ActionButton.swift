//
//  ActionButton.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

enum ActionButtonCase {
    case close
    case back
}

struct ActionButton: View {
    let type: ActionButtonCase
    private var text: String {
        switch type {
        case .close:
            "X"
        case .back:
            "<"
        }
    }
    
    private var overlay: Color {
        switch type {
        case .close:
                .redButtonOverlay
        case .back:
                .blueBackground
        }
    }
    
    private var stroke: Color {
        switch type {
        case .close:
                .redButtonStroke
        case .back:
                .blueStroke
        }
    }
    
    private var shadow: Color {
        switch type {
        case .close:
                .redButtonShadow
        case .back:
                .blueShadow
        }
    }
    
    private var font: Font {
        switch type {
        case .close:
                .escavatorUI(.body3Regular)
        case .back:
                .escavatorUI(.body4Regular)
        }
    }
    
    var body: some View {
        ZStack {
            ActionMapShape(crackPosition: .left)
                .frame(width: 36, height: 37)
                .foregroundStyle(shadow)
                .offset(y: 2.5)
            
            ActionMapShape(crackPosition: .left)
                .frame(width: 36, height: 37)
                .foregroundStyle(stroke)
                .overlay {
                    ActionMapShape(crackPosition: .left)
                        .foregroundStyle(overlay)
                        .padding(2.5)
                }
            
            Text(text)
                .font(font)
                .foregroundStyle(.white)
                .dynamicTypeSize(DynamicTypeSize.xLarge...DynamicTypeSize.xxxLarge)
                .padding(.bottom, type == .back ? 6 : 0)
        }
    }
}

#Preview {
    ActionButton(type: .close)
}
