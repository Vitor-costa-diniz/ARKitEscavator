//
//  UIKitMap.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI
import MapKit

struct UIKitMap: UIViewRepresentable {
    let majorSites: [MajorSite]
    @StateObject var viewModel: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.userTrackingMode = .follow
        mapView.showsCompass = false
        
        viewModel.mapView = mapView
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.annotations.isEmpty {
            for escavation in majorSites {
                escavation.escavationPoints.forEach {
                    let point = MKPointAnnotation()
                    point.title = $0.name
                    point.coordinate = $0.coordinates
                    uiView.addAnnotation(point)
                    
                    let circle = MKCircle(center: $0.coordinates, radius: viewModel.radius)
                    uiView.addOverlay(circle)
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circleOverlay)
                renderer.fillColor = UIColor.systemBrown.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor(resource: .mapBorderRadius)
                renderer.lineWidth = 1
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "customPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
                annotationView?.image = UIImage(resource: .mapPin)
                annotationView?.centerOffset = CGPoint(x: 0, y:  -annotationView!.frame.height / 3)
            } else {
                annotationView?.annotation = annotation
                annotationView?.image = UIImage(resource: .mapPin)
            }
            
            return annotationView
        }
    }
}

#Preview {
    UIKitMap(majorSites: [.init()], viewModel: .init())
}
