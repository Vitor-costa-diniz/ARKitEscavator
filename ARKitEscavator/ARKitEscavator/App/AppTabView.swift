//
//  AppTabView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 12/06/25.
//

import SwiftUI

struct AppTabView: View {
    @State private var tabSelection: Int = 0
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Tab("Mapa", systemImage: "map", value: 0) {
                MapView()
                    .environmentObject(viewModel)
            }
            
            Tab("Bau", systemImage: "house", value: 1) {
                Text("Bau")
            }
        }
    }
}


#Preview {
    AppTabView()
}
