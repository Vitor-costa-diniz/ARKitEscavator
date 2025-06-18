//
//  ActionMapShape.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct ActionMapShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Top
        path.addLine(to: CGPoint(x: 27, y: -1))
        path.addLine(to: CGPoint(x: 36, y: 0))
        
        // Right
        path.addLine(to: CGPoint(x: 36, y: 37))
        path.addLine(to: CGPoint(x: 24, y: 36))
        
        // Bottom
        path.addLine(to: CGPoint(x: 0, y: 37))
        
        // Left
        path.addLine(to: CGPoint(x: 0, y: 18))
        path.addLine(to: CGPoint(x: 3, y: 14.5))
        path.addLine(to: CGPoint(x: 0, y: 11.5))
        
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
