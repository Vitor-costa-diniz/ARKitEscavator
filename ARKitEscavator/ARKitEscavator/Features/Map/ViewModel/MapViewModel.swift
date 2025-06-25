//
//  MapViewModel.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import MapKit
import SwiftUI
import CoreLocation

final class MapViewModel: ObservableObject, LocationManagerDelegate {
    private var locationManager: LocationManager = LocationManager.shared
    var escavationSites: [MajorSite] = MajorSite.loadAllMajorSites()
    weak var mapView: MKMapView?
    @Published var centeredMapOnUser: Bool = true
    @Published var radius: Double = 30
    @Published var userLocation: String = "Carregando..."
    
    init() {
        locationManager.delegate = self
    }
    
    func monitoringRegion() {
        locationManager.monitoringRegion(points: escavationSites, radius: radius) { point in
            print("Entrou no raio de: \(point.name)")
        }
    }
    
    func resetHeadingToNorth() {
        if let mapView = mapView {
            let camera = mapView.camera
            let newCamera = camera.copy() as! MKMapCamera
            newCamera.heading = 0
            
            UIView.animate(withDuration: 0.6) {
                mapView.setCamera(newCamera, animated: true)
            }
        }
    }
    
    func didUpdateUserLocation(_ coordinate: CLLocationCoordinate2D) {
        if userLocation == "Carregando..." {
            getCityAndState(from: coordinate)
        }
    }
    
    func centerMapOnUser() {
        mapView?.setUserTrackingMode(.follow, animated: true)
    }
}

// MARK: Private funcs
extension MapViewModel {
    private func getCityAndState(from coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Erro ao obter cidade e estado: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            let city = placemark.locality ?? placemark.subAdministrativeArea ?? "Cidade desconhecida"
            let state = placemark.administrativeArea ?? "Estado desconhecido"
            
            DispatchQueue.main.async {
                self.userLocation = "\(city) - \(state)"
            }
        }
    }
}
