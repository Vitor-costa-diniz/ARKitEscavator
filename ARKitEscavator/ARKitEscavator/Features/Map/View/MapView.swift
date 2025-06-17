//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    
    var body: some View {
        ZStack {
            UIKitMap(majorSites: [.init()], radius: viewModel.radius)
                .ignoresSafeArea()
        }
        .onAppear {
            viewModel.monitoringRegion()
        }
    }
}

#Preview {
    MapView()
        .environmentObject(MapViewModel())
}
