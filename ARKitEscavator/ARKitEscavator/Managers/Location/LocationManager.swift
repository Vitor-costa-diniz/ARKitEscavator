//
//  LocationManager.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 12/06/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    static let shared: LocationManager = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    private var monitoredSites: [EscavationSite] = [.init()]
    private var radius: Double = 10
    private var onEnterRegion: ((EscavationSite) -> Void)?

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        requestPermission()
    }
    
    func monitoringRegion(points: [MajorEscavationSite], radius: Double, onEnter: @escaping (EscavationSite) -> Void) {
        stopMonitoringAllRegions()
        self.monitoredSites = points.flatMap { $0.escavations }
        self.onEnterRegion = onEnter
        self.radius = radius
        
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            print("Geofencing is not supported on this device.")
            return
        }
        
        for site in self.monitoredSites {
            let region = CLCircularRegion(
                center: site.coordinates,
                radius: radius,
                identifier: site.id.uuidString
            )
            
            region.notifyOnEntry = true
            region.notifyOnExit = false
            
            manager.startMonitoring(for: region)
            
            if region.contains(manager.location?.coordinate ?? CLLocationCoordinate2D()) {
                DispatchQueue.main.async {
                    self.onEnterRegion?(site)
                }
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let site = monitoredSites.first(where: { $0.id.uuidString == region.identifier }) else {
            print("Could not find a matching site for region identifier: \(region.identifier)")
            return
        }
        
        DispatchQueue.main.async {
            self.onEnterRegion?(site)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização: \(error.localizedDescription)")
    }
}

extension LocationManager {
    private func stopMonitoringAllRegions() {
        for region in manager.monitoredRegions {
            manager.stopMonitoring(for: region)
        }
    }
    
    private func requestPermission() {
        let status = manager.authorizationStatus

        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
        case .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
}
