//
//  EscavationPointAnnotation.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 26/06/25.
//


import SwiftUI
import MapKit

class EscavationPointAnnotation: MKPointAnnotation {
    var point: EscavationPoint

    init(point: EscavationPoint) {
        self.point = point
        super.init()
        self.coordinate = point.coordinates
        self.title = point.name
    }
}