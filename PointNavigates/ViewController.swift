//  ViewController.swift
//  PointNavigates
//  Created by Jerry Tan on 12/07/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections


class ViewController: UIViewController, MGLMapViewDelegate {
    
    
    
    //NavigationMapView is a subclass of MGLMapView with convenience functions for adding Route lines to a map
    var mapView: NavigationMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The bounds rectangle, which describes the view’s location and size in its own coordinate system
        mapView = NavigationMapView(frame: view.bounds)
        //Adds a view to the end of the receiver’s list of subviews
        view.addSubview(mapView)
        
        
    }
}

