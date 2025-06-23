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
            UIKitMap(majorSites: [.init()], viewModel: viewModel)
                .ignoresSafeArea()
            
            mapInformationAction
                .padding(EdgeInsets(top: 8, leading: 25, bottom: 0, trailing: 20))
        }
        .onAppear {
            viewModel.monitoringRegion()
        }
    }
    
    private var mapInformationAction: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                LabelComponent(text: "Fortaleza - CE")
                
                Spacer()
                
                VStack(spacing: 8) {
                    ActionMapButton(icon: .info) {}
                    
                    ActionMapButton(icon: .location) {
                        viewModel.centeredMapOnUser = true
                    }
                    
                    ActionMapButton(icon: .locationNorth) {}
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
