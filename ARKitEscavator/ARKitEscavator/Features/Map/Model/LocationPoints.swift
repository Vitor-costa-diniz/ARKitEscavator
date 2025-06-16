//
//  LocationPoints.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import MapKit

struct MajorEscavationSite {
    let title: String
    let escavations: [EscavationSite]
    
    init(title: String, escavations: [EscavationSite]) {
        self.title = title
        self.escavations = escavations
    }
    
    init() {
        title = "Apple Developer Academy"
        self.escavations = [.init(title: "Sala 05", coordinates: CLLocationCoordinate2D(latitude: -3.744459241140999, longitude: -38.53652440961214))]
    }
}

struct EscavationSite {
    let title: String
    let coordinates: CLLocationCoordinate2D
    
    init(title: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.coordinates = coordinates
    }
}
