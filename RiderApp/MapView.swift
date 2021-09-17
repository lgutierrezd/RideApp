//
//  MapView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 16/9/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
    var centerCoordinate: CLLocationCoordinate2D
    var mapAnnotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setCenter(CLLocationCoordinate2DMake(10.1662136, -84.3999526), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if mapAnnotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(mapAnnotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var mapViewParent: MapView
        init(_ parent: MapView) {
            self.mapViewParent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            mapViewParent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

extension MKPointAnnotation {
    static var myHomeMapAnnotation: MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.title = "Plaza futbol Barranca"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 10.1662136, longitude: -84.3999526)
        return annotation
    }
}

struct MapView_Preview: PreviewProvider{
    static var previews: some View{
        MapView(centerCoordinate: MKPointAnnotation.myHomeMapAnnotation.coordinate, mapAnnotations: [MKPointAnnotation.myHomeMapAnnotation])
    }
}

