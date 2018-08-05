//
//  MapViewController.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    
    override func loadView() {
        view = MapView()
    }
    
    var contentView: MapView { return view as! MapView }
    var map: MKMapView { return contentView.map }
    
    private let context: MapContext
    
    init(context: MapContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpMapView()
    }
    
    private func setUpNavigationItem() {
        let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapClose))
        navigationItem.title = "Map"
        navigationItem.leftBarButtonItem = close
    }
    
    @objc
    private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpMapView() {
        map.delegate = self
        map.addAnnotations(context.annotations)
        map.showAnnotations(context.annotations, animated: false)
        map.register(MKMarkerAnnotationView.self,
                     forAnnotationViewWithReuseIdentifier: markerReuseIdentifier)
    }
    
    private let markerReuseIdentifier = "MKMarkerAnnotationView"
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = mapView.dequeueReusableAnnotationView(
            withIdentifier: markerReuseIdentifier,
            for: annotation) as! MKMarkerAnnotationView
        marker.displayPriority = .required
        return marker
    }
}
