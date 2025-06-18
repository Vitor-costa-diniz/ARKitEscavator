//
//  LabelComponent.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct LabelComponent: View {
    var body: some View {
        ZStack {
            LabelShape()
                .frame(width: 141.5, height: 37)
                .foregroundStyle(.buttonShadow)
                .offset(y: 2.5)
            
            LabelShape()
                .foregroundStyle(.buttonStroke)
                .frame(width: 141.5, height: 37)
                .overlay {
                    LabelShape()
                        .foregroundStyle(.buttonOverlay)
                        .padding(2.5)
                }
        }
    }
}

#Preview {
    LabelComponent()
}
