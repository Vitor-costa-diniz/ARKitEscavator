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
    @State private var showARView: Bool = false
    
    var body: some View {
        ZStack {
            UIKitMap(viewModel: viewModel) {
                viewModel.selectedPoint = $0
            }
                .ignoresSafeArea()
            
            mapInformationAction
                .padding(EdgeInsets(top: 8, leading: 25, bottom: 0, trailing: 20))
        }
        .sheet(item: $viewModel.selectedPoint, onDismiss: {
            viewModel.selectedPoint = nil
        }, content: { _ in
            EscavationPointSheet(viewModel: viewModel)
        })
        .fullScreenCover(isPresented: $showARView, content: {
            ARViewContainer(site: viewModel.selectedPoint ?? .init())
                .ignoresSafeArea()
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
