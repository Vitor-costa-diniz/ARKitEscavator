//
//  MapView.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        UIKitMap(majorSites: [.init()])
            .ignoresSafeArea()
    }
}

#Preview {
    MapView()
}
