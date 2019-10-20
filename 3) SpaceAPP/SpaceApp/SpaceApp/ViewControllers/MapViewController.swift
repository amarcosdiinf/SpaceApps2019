//
//  MapViewController.swift
//  SpaceApp
//
//  Created by Administrador on 19/10/2019.
//  Copyright © 2019 valde. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.4165000, longitude: -3.7025600), zoomLevel: 5, animated: false)
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle)
    {
        let source = MGLVectorTileSource(identifier: "historical-places", configurationURL: URL(string: "mapbox://upnasa.aj9uyr00")!)
        
        style.addSource(source)
        
        let layer = MGLCircleStyleLayer(identifier: "landmarks", source: source)
        
        layer.sourceLayerIdentifier = "HPC_landmarks-b60kqn"
        
        layer.circleColor = NSExpression(forConstantValue: #colorLiteral(red: 0.67, green: 0.28, blue: 0.13, alpha: 1))
        
        layer.circleOpacity = NSExpression(forConstantValue: 0.8)
        
        let zoomStops = [
            10: NSExpression(format: "(2018 - Constructi) / 30"),
            13: NSExpression(format: "(2018 - Constructi) / 10")
        ]
        
        layer.circleRadius = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)", zoomStops)
        
        style.addLayer(layer)
    }
}
