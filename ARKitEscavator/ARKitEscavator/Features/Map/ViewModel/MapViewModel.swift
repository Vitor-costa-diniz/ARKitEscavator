//
//  MapViewModel.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import Foundation

final class MapViewModel: ObservableObject {
    var locationManager: LocationManager = LocationManager.shared
    @Published var radius: Double = 10
}
