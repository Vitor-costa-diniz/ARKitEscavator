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
    
    var body: some View {
        ZStack {
            ActionMapShape()
                .frame(width: 36, height: 37)
                .foregroundStyle(.buttonShadow)
                .offset(y: 2.5)
            
            ActionMapShape()
                .frame(width: 36, height: 37)
                .foregroundStyle(.buttonStroke)
                .overlay {
                    ActionMapShape()
                        .foregroundStyle(.buttonOverlay)
                        .padding(2.5)
                }
            
            Image(systemName: icon.rawValue)
                .font(.system(size: 20.7, weight: .regular))
                .foregroundStyle(.buttonShadow)
        }
        .onTapGesture {}
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
