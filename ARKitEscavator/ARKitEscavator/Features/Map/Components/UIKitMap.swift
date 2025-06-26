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
    let onSelectSite: (EscavationSite) -> Void


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

        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)

        for escavation in majorSites {
            escavation.escavations.forEach { site in
                let point = MKPointAnnotation()
                point.title = site.title
                point.coordinate = site.coordinates
                uiView.addAnnotation(point)

                let circle = MKCircle(center: site.coordinates, radius: radius)
                uiView.addOverlay(circle)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(majorSites: majorSites, onSelectSite: onSelectSite)
    }


    class Coordinator: NSObject, MKMapViewDelegate {
        private let sites: [EscavationSite]
        private let onSelectSite: (EscavationSite) -> Void

        init(majorSites: [MajorEscavationSite],
             onSelectSite: @escaping (EscavationSite) -> Void) {
            self.sites = majorSites.flatMap { $0.escavations }
            self.onSelectSite = onSelectSite
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }

            if annotation is MKUserLocation {
                return
            }

            guard let ann = annotation as? MKPointAnnotation else { return }

            let coord = ann.coordinate
            if let site = sites.first(where: {
                abs($0.coordinates.latitude  - coord.latitude)  < 0.000001 &&
                abs($0.coordinates.longitude - coord.longitude) < 0.000001
            }) {
                onSelectSite(site)
            }
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
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

//#Preview {
//    UIKitMap(majorSites: [.init()], radius: 10)
//}
