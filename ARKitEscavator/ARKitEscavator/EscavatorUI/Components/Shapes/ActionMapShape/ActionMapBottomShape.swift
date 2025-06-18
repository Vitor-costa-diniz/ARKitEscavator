//
//  File.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct ActionMapBottomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        func px(_ x: CGFloat) -> CGFloat { x / 36 * w }
        func py(_ y: CGFloat) -> CGFloat { y / 37 * h }
        
        var path = Path()
        path.move(to: CGPoint(x: px(0), y: py(0)))
        
        // Top
        path.addLine(to: CGPoint(x: px(36), y: py(0)))
        
        // Right
        path.addLine(to: CGPoint(x: px(35), y: py(8)))
        path.addLine(to: CGPoint(x: px(36), y: py(37)))
        
        // Bottom
        path.addLine(to: CGPoint(x: px(0), y: py(37)))
        path.addLine(to: CGPoint(x: px(17), y: py(37)))
        path.addLine(to: CGPoint(x: px(13.5), y: py(34)))
        path.addLine(to: CGPoint(x: px(10.5), y: py(37)))
        path.addLine(to: CGPoint(x: px(0), y: py(37)))
        
        // Left
        path.addLine(to: CGPoint(x: px(0), y: py(37)))
        path.addLine(to: CGPoint(x: px(-1), y: py(10)))
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    VStack {
        ActionMapBottomShape()
            .frame(width: 36, height: 37)
    }
}
