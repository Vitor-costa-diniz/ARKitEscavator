//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            UIKitMap(majorSites: viewModel.escavationSites, viewModel: viewModel)
                .ignoresSafeArea()
            
            mapInformationAction
                .padding(EdgeInsets(top: 8, leading: 25, bottom: 0, trailing: 20))
        }
        .sheet(isPresented: $showSheet, content: {
            EscavationPointSheet(escavationPoint: .init())
        })
        .onAppear {
            viewModel.monitoringRegion()
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
