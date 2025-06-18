//
//  LabelShape.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct LabelShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        func px(_ x: CGFloat) -> CGFloat { x / 141.5 * w }
        func py(_ y: CGFloat) -> CGFloat { y / 37 * h }

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        //Top
        path.addLine(to: CGPoint(x: px(27), y: py(-1)))
        path.addLine(to: CGPoint(x: px(84.25), y: py(1.5)))
        path.addLine(to: CGPoint(x: px(141.5), y: py(0)))
        
        // Right
        path.addLine(to: CGPoint(x: px(141.5), y: py(18)))
        path.addLine(to: CGPoint(x: px(138.5), y: py(27)))
        path.addLine(to: CGPoint(x: px(141.5), y: py(37)))
        
        // Bottom
        path.addLine(to: CGPoint(x: px(115.5), y: py(34.5)))
        path.addLine(to: CGPoint(x: px(28), y: py(36)))
        path.addLine(to: CGPoint(x: px(0), y: py(37)))
        
        // Left
        path.addLine(to: CGPoint(x: px(0), y: py(17)))
        path.addLine(to: CGPoint(x: px(3), y: py(13.5)))
        path.addLine(to: CGPoint(x: px(0), y: py(10.5)))

        path.closeSubpath()
        return path
    }
}

#Preview {
    LabelShape()
        .frame(width: 141.5, height: 37)
}
