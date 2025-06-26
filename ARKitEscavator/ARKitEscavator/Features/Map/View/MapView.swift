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
    // @State private var showAR = false
    @State private var showCameraPermissionAlert = false

    var body: some View {
        ZStack {
<<<<<<< feature/ObjectsPosition
            UIKitMap(
                majorSites: viewModel.escavationSites,
                radius: viewModel.radius,
                onSelectSite: { site in
                    selectedSite = site
                }
            )
            .ignoresSafeArea()
        }
        .fullScreenCover(item: $selectedSite) { site in
            ARExperienceView(site: site)
=======
            UIKitMap(majorSites: [.init()], viewModel: viewModel)
                .ignoresSafeArea()
            
            mapInformationAction
                .padding(EdgeInsets(top: 8, leading: 25, bottom: 0, trailing: 20))
>>>>>>> main
        }
        .onAppear {
            viewModel.monitoringRegion()
            //viewModel.selectedSite
        }
    }
    
    private var mapInformationAction: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                LabelComponent(text: viewModel.userLocation)
                
                Spacer()
                
                VStack(spacing: 8) {
                    ActionMapButton(icon: .menu) {}
                    
                    ActionMapButton(icon: .location) {
                        viewModel.centerMapOnUser()
                    }
                    
                    ActionMapButton(icon: .locationNorth) {
                        viewModel.resetHeadingToNorth()
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    MapView()
        .environmentObject(MapViewModel())
}
