//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI
import AVFoundation

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    @State private var selectedSite: EscavationSite?
    @State private var showAR = false
    @State private var showCameraPermissionAlert = false

    var body: some View {
        ZStack {
            UIKitMap(
                majorSites: viewModel.escavationSites,
                radius: viewModel.radius,
                onSelectSite: { site in
                    selectedSite = site
                    showAR = true
                }
            )
            .ignoresSafeArea()
        }
        .fullScreenCover(item: $viewModel.selectedSite, content: { _ in
            if let site = viewModel.selectedSite {
                ARExperienceView(site: site)
            } else {
                Text("teste")
            }
        })
        .onAppear {
            viewModel.monitoringRegion()
        }
    }
}

#Preview {
    MapView()
        .environmentObject(MapViewModel())
}
