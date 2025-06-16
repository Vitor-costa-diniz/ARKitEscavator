//
//  UIKitMap.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI
import MapKit

struct UIKitMap: UIViewRepresentable {
    let point: MKPointAnnotation = .init()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.userTrackingMode = .follow
        
        let coordinate = CLLocationCoordinate2D(latitude: -3.744459241140999, longitude: -38.53652440961214)
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        
        mapView.setRegion(region, animated: true)
        
        let circle = MKCircle(center: coordinate, radius: 10)
        mapView.addOverlay(circle)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        point.coordinate = CLLocationCoordinate2D(latitude: -3.744459241140999, longitude: -38.53652440961214)
        point.title = "Apple developer Academy"
        uiView.addAnnotation(point)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circleOverlay)
                renderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.3)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

#Preview {
    UIKitMap()
}
