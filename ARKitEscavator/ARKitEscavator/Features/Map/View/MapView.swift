//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI

struct MapView: View {
    @StateObject var viewModel = MapViewModel()

    var body: some View {
        ZStack {
            UIKitMap(majorSites: [.init()], radius: viewModel.radius)
                .ignoresSafeArea()
            
            Button {
                viewModel.radius += 5
            } label: {
                Text("Aumentar radius")
            }
            .offset(x: 50, y: -200)
        }
        .onAppear {
            viewModel.locationManager.monitoringRegion(points: [.init()], radius: viewModel.radius) {
                print("Entrei na região \($0.title)")
            }
        }
    }
}

#Preview {
    MapView()
}
