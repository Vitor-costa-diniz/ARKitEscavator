//
//  CustomTabBar.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 24/06/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selection: Int
    
    var body: some View {
        GeometryReader { geo in
            Group {
                ZStack {
                    SheetShape()
                        .offset(y: -3)
                        .foregroundStyle(.buttonStroke)
                    
                    SheetShape()
                        .foregroundStyle(.buttonOverlay)
                }
                
                HStack {
                    VStack(spacing: 6) {
                        Image(systemName: selection == 0 ? "map.fill" : "map")
                            .font(.system(size: 22))
                        
                        Text("Explorar")
                            .font(.escavatorUI(.headingManjari5))
                    }
                    .foregroundStyle(selection == 0 ? Color.buttonIcon : .gray)
                    .onTapGesture {
                        selection = 0
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Image(systemName: selection == 1 ? "backpack.fill" : "backpack")
                            .font(.system(size: 22))
                        
                        Text("Coleção")
                            .font(.escavatorUI(.headingManjari5))
                    }
                    .foregroundStyle(selection == 1 ? Color.buttonIcon : .gray)
                    .onTapGesture {
                        selection = 1
                    }
                    
                }
                .padding(.top, geo.size.height * 0.03)
                .padding(.horizontal, 84)
            }
            .offset(y: geo.size.height * 0.86)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    CustomTabBar(selection: .constant(0))
}
