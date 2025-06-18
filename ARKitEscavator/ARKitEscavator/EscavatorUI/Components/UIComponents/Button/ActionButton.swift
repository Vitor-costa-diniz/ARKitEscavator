//
//  ActionButton.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct ActionButton: View {
    var body: some View {
        ZStack {
            ActionMapShape(crackPosition: .left)
                .frame(width: 36, height: 37)
                .foregroundStyle(.redButtonShadow)
                .offset(y: 2.5)
            
            ActionMapShape(crackPosition: .left)
                .frame(width: 36, height: 37)
                .foregroundStyle(.redButtonStroke)
                .overlay {
                    ActionMapShape(crackPosition: .left)
                        .foregroundStyle(.redButtonOverlay)
                        .padding(2.5)
                }
            
            Text("X")
                .font(.escavatorUI(.body3Regular))
                .foregroundStyle(.white)
                .dynamicTypeSize(DynamicTypeSize.xLarge...DynamicTypeSize.xxxLarge)
        }
    }
}

#Preview {
    ActionButton()
}
