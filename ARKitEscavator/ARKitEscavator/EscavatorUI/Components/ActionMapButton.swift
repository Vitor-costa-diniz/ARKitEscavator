//
//  ActionMapButton.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI

struct ActionMapButton: View {
    let icon: ActionIcon
    let action: () -> Void
    @State private var position: CrackPosition = .right
    
    var body: some View {
        ZStack {
            ActionMapShape(crackPosition: position)
                .frame(width: 36, height: 37)
                .foregroundStyle(.buttonShadow)
                .offset(y: 2.5)
            
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
                .foregroundStyle(.buttonShadow)
        }
        .onTapGesture {}
        .onAppear {
            switch icon {
            case .info:
                position = .left
            case .location:
                position = .right
            case .locationNorth:
                position = .bottom
            }
        }
    }
}

#Preview {
    ActionMapButton(icon: .info) {}
}

enum ActionIcon: String {
    case info = "info.circle"
    case location = "location"
    case locationNorth = "location.north.line"
}
