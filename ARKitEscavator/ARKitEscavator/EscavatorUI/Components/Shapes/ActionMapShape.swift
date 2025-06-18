//
//  ActionMapShape.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct ActionMapShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        func px(_ x: CGFloat) -> CGFloat { x / 36 * w }
        func py(_ y: CGFloat) -> CGFloat { y / 37 * h }

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Top
        path.addLine(to: CGPoint(x: px(27), y: py(-1)))
        path.addLine(to: CGPoint(x: px(36), y: py(0)))
        
        // Right
        path.addLine(to: CGPoint(x: px(36), y: py(37)))
        path.addLine(to: CGPoint(x: px(24), y: py(36)))
        
        // Bottom
        path.addLine(to: CGPoint(x: px(0), y: py(37)))
        
        // Left
        path.addLine(to: CGPoint(x: px(0), y: py(18)))
        path.addLine(to: CGPoint(x: px(3), y: py(14.5)))
        path.addLine(to: CGPoint(x: px(0), y: py(11.5)))
        
        path.closeSubpath()
        return path
    }
}


#Preview {
    VStack {
        ActionMapShape()
            .frame(width: 36, height: 37)
    }
}
