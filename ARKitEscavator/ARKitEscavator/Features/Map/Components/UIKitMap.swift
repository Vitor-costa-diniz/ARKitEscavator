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

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.userTrackingMode = .follow
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
            guard
                let ann = view.annotation as? MKPointAnnotation
            else { return }

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
                renderer.fillColor   = UIColor.systemRed.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor.systemRed
                renderer.lineWidth   = 1
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

//#Preview {
//    UIKitMap(majorSites: [.init()], radius: 10)
//}
