//
//  AppTabView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 12/06/25.
//

import SwiftUI

struct AppTabView: View {
    @State private var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Tab("Mapa", systemImage: "map", value: 0) {
                MapView()
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
