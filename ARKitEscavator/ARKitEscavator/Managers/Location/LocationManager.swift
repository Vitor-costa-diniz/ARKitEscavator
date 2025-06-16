//
//  LocationManager.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 12/06/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared: LocationManager = LocationManager()
    
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    private var monitoredSites: [MajorEscavationSite] = [.init()]
    private var radius: Double = 20
    private var onEnterRegion: ((EscavationSite) -> Void)?

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        requestPermission()
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func monitoringRegion(points: [MajorEscavationSite], radius: Double, onEnter: @escaping (EscavationSite) -> Void) {
        self.monitoredSites = points
        self.radius = radius
        self.onEnterRegion = onEnter
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
                self.checkIfEnteredRegion(userCoord: self.userLocation ?? CLLocationCoordinate2D(latitude: -3.744459241140999, longitude: -38.53652440961214))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização: \(error.localizedDescription)")
    }
}

extension LocationManager {
    private func checkIfEnteredRegion(userCoord: CLLocationCoordinate2D) {
        let userLoc = CLLocation(latitude: userCoord.latitude, longitude: userCoord.longitude)
        let allPoints = monitoredSites.flatMap({ $0.escavations})

        for point in allPoints {
            let targetLoc = CLLocation(latitude: point.coordinates.latitude, longitude: point.coordinates.longitude)
            let distance = userLoc.distance(from: targetLoc)
            
            if distance <= radius {
                onEnterRegion?(point)
                return
            }
        }
    }
}
