//
//  MapViewModel.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import Foundation

final class MapViewModel: ObservableObject {
    private var locationManager: LocationManager = LocationManager.shared
    var escavationSites: [MajorEscavationSite] = [.init()]
    @Published var radius: Double = 30
    @Published var selectedSite: EscavationSite?
    
    func monitoringRegion() {
        locationManager.monitoringRegion(points: escavationSites, radius: radius) { point in
            self.selectedSite = point
        }
    }
}
