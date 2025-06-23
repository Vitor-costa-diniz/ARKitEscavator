//
//  SheetShape.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct SheetShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        func px(_ x: CGFloat) -> CGFloat { x / 57 * w }
        func py(_ y: CGFloat) -> CGFloat { y / 100 * h }

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))

        path.addLine(to: CGPoint(x: px(2.2), y: py(0.26)))
        path.addLine(to: CGPoint(x: px(4.46), y: py(0.53)))
        path.addLine(to: CGPoint(x: px(12.84), y: py(0.75)))

        path.addLine(to: CGPoint(x: px(13.76), y: py(1.73)))
        path.addLine(to: CGPoint(x: px(14.79), y: py(0.75)))

        path.addLine(to: CGPoint(x: px(33.21), y: py(0)))
        path.addLine(to: CGPoint(x: px(45.83), y: py(0.45)))

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        path.closeSubpath()
        return path
    }
}


#Preview {
    VStack {
        SheetShape()
    }
}
