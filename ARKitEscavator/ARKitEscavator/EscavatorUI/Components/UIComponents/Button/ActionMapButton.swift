//
//  ActionMapButton.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

enum ActionIcon: String {
    case menu = "list.bullet"
    case location = "location"
    case locationNorth = "location.north.line"
}

struct ActionMapButton: View {
    let icon: ActionIcon
    let action: () -> Void
    private var position: CrackPosition {
        switch icon {
        case .menu:
            return .left
        case .location:
            return .right
        case .locationNorth:
            return .bottom
        }
    }
    
    var body: some View {
        ZStack {
            if position == .bottom {
                ActionMapBottomShadowShape()
                                    .frame(width: 36, height: 37)
                                    .foregroundStyle(.buttonShadow)
                                    .offset(y: 2.5)
            } else {
                ActionMapShape(crackPosition: position)
                    .frame(width: 36, height: 37)
                    .foregroundStyle(.buttonShadow)
                    .offset(y: 2.5)
            }
            
            ActionMapShape(crackPosition: position)
                .frame(width: 36, height: 37)
                .foregroundStyle(.buttonStroke)
                .overlay {
                    ActionMapShape(crackPosition: position)
                        .foregroundStyle(.buttonOverlay)
                        .padding(2.5)
                }
            
            Image(systemName: icon.rawValue)
                .font(.system(size: 20.7, weight: .regular))
                .foregroundStyle(.buttonIcon)
        }
        .onTapGesture { action() }
    }
}

#Preview {
    ActionMapButton(icon: .locationNorth) {}
}
