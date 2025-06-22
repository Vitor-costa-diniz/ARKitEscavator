//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    @State private var selectedSite: EscavationSite?
    @State private var showAR = false

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
        .fullScreenCover(isPresented: $showAR) {
            if let site = selectedSite {
                ARExperienceView(site: site)
            }
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
