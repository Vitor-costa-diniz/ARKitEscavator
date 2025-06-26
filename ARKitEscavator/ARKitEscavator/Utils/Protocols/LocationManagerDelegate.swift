//
//  LocationManagerDelegate.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 25/06/25.
//

import MapKit

protocol LocationManagerDelegate: AnyObject {
    func didUpdateUserLocation(_ coordinate: CLLocationCoordinate2D)
}
