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
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection) {
                Tab("Explorar", systemImage: "map", value: 0) {
                    MapView()
                        .environmentObject(viewModel)
                }
                
                Tab("Coleção", systemImage: "house", value: 1) {
                    Text("Bau")
                }
            }
            
            CustomTabBar(selection: $tabSelection)
        }
        .tint(.buttonIcon)
    }
}


#Preview {
    AppTabView()
}
