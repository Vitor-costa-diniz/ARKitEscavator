//
//  CollectionView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 28/06/25.
//

import SwiftUI

struct CollectionView: View {
    @State private var selectedSite: MajorSite?
    
    var body: some View {
        GeometryReader { geo in
            Color.buttonOverlay
                .ignoresSafeArea()
            
            Image(.collectionSprayTop)
                .offset(x: geo.size.height * 0.02, y: -geo.size.height * 0.22)
            
            VStack {
                Text("Coleção")
                    .font(.escavatorUI(.body5Regular))
                    .foregroundStyle(.buttonIcon)
                
                ScrollView {
                    ForEach(MajorSite.loadAllMajorSites()) { site in
                        CollectionPoints(point: site) {
                            selectedSite = site
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                Spacer()
            }
        }
        .onAppear {
            UIScrollView.appearance().delaysContentTouches = false
        }
    }
}

#Preview {
    CollectionView()
}
