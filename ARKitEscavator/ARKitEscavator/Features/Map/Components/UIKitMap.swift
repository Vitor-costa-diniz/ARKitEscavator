//
//  UIKitMap.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 16/06/25.
//

import SwiftUI
import MapKit

struct UIKitMap: UIViewRepresentable {
    let majorSites: [MajorEscavationSite]
    let radius: Double
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.annotations.isEmpty {
            for escavation in majorSites {
                escavation.escavations.forEach {
                    let point = MKPointAnnotation()
                    point.title = $0.title
                    point.coordinate = $0.coordinates
                    uiView.addAnnotation(point)
                    
                    let circle = MKCircle(center: $0.coordinates, radius: radius)
                    uiView.addOverlay(circle)
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        private var hasCenteredOnUser = false
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            if !hasCenteredOnUser {
                let region = MKCoordinateRegion(
                    center: userLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                mapView.setRegion(region, animated: true)
                
                hasCenteredOnUser = true
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circleOverlay)
                renderer.fillColor = UIColor.systemRed.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor(resource: .mapBorderRadius)
                renderer.lineWidth = 1
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
    UIKitMap(majorSites: [.init()], radius: 10)
}
