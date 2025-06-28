//
//  CollectionView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 28/06/25.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color.buttonOverlay
                    .ignoresSafeArea()
                
                Image(.collectionSprayTop)
                    .offset(x: geo.size.height * 0.02, y: -geo.size.height * 0.22)
                
                VStack {
                    Text("Coleção")
                        .font(.escavatorUI(.body5Regular))
                        .foregroundStyle(.buttonIcon)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CollectionView()
}
