//
//  ActionMapShape.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

enum CrackPosition {
    case left, right, bottom
}

import SwiftUI

struct ActionMapShape: Shape {
    var crackPosition: CrackPosition

    func path(in rect: CGRect) -> Path {
        switch crackPosition {
        case .bottom:
            return ActionMapBottomShape().path(in: rect)
        default:
            return ActionMapSideShape(crackPosition: crackPosition).path(in: rect)
        }
    }
}

#Preview {
    VStack {
        ActionMapShape(crackPosition: .bottom)
            .frame(width: 36, height: 37)
    }
}
