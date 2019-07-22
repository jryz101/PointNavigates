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
    
    
    //MARK: GLOBAL VARIABLE SECTION
    
    //NavigationMapView is a subclass of MGLMapView with convenience functions for adding Route lines to a map
    var mapView: NavigationMapView!
    
    //Navigate UIButton
    var navigateButton: UIButton!
    
    //Route object
    var directionsRoute: Route?
    
    
    
    
    
    
    //MARK: VIEW DID LOAD SECTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: MAP VIEW SETTINGS
        
        //The bounds rectangle, which describes the view’s location and size in its own coordinate system
        mapView = NavigationMapView(frame: view.bounds)
        //Adds a view to the end of the receiver’s list of subviews
        view.addSubview(mapView)
        
        
        
        
        //MARK: USER LOCATION & DELEGATE SETTINGS
        
        //The receiver’s delegate
        mapView.delegate = self
        //Get user location
        mapView.showsUserLocation = true
        
        
        //MARK: USER TRACKING
        
        
        //Sets the mode used to track the user location, with an optional transition
        mapView.setUserTrackingMode(.follow, animated: true)
        
        
        //Call addButton function
        addButton()
    }
    
    
    
    //MARK: BUTTON FUNCTION
    
    //addButton function
    func addButton() {
        
        //Button frame, a control that executes your custom code in response to user interactions
        navigateButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 100, y: view.frame.height - 75, width: 200, height: 50))
        //The button view’s background color
        navigateButton.backgroundColor = UIColor.white
        //Sets the button title to use for the specified state
        navigateButton.setTitle("NAVIGATE", for: .normal)
        //Sets the color of the title to use for the specified state
        navigateButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        //The font used to display the text
        navigateButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        //The radius to use when drawing rounded corners for the layer’s background. Animatable
        navigateButton.layer.cornerRadius = 25
        //The offset (in points) of the layer’s shadow. Animatable
        navigateButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        //The color of the layer’s shadow. Animatable
        navigateButton.layer.shadowColor = UIColor.black.cgColor
        //The blur radius (in points) used to render the layer’s shadow. Animatable
        navigateButton.layer.shadowRadius = 5
        //The opacity of the layer’s shadow. Animatable
        navigateButton.layer.shadowOpacity = 0.3
        
        
        
        //Associates a target object and action method with the control
        navigateButton.addTarget(self, action: #selector(navigateButtonWasPressed(_:)), for: .touchUpInside)
        
        //Add button to SubView
        view.addSubview(navigateButton)
        
    }
    
    //MARK: NAVIGATE BUTTON WAS PRESSED ACTION
    
    //Button action
    @objc func navigateButtonWasPressed(_ sender: UIButton) {
    
    }
    
    
    //Calculate route function
    func calculateRoute(from originCoor: CLLocationCoordinate2D, to destinationCoor: CLLocationCoordinate2D, completion: @escaping (Route?, Error?)->Void){
        
        //A Waypoint object indicates a location along a route. It may be the route’s origin or destination, or it may be another location that the route visits. A waypoint object indicates the location’s geographic location along with other optional information, such as a name or the user’s direction approaching the waypoint. You create a RouteOptions object using waypoint objects and also receive waypoint objects in the completion handler of the Directions.calculate(_:completionHandler:) method
        let origin = Waypoint(coordinate: originCoor, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destinationCoor, coordinateAccuracy: -1, name: "Finish")
        
        //A NavigationRouteOptions object specifies turn-by-turn-optimized criteria for results returned by the Mapbox Directions API.
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        
        
        //Begins asynchronously calculating routes using the given options and delivers the results to a closure
        _ = Directions.shared.calculate(options, completionHandler: { (waypoints, routes, error) in
            
            //MARK: - COMPLETION BLOCK
            
            //Set directionsRoute object equals to routes?.first
            self.directionsRoute = routes?.first
            
            //A rectangular area as measured on a two-dimensional map projection
            let coordinateBounds = MGLCoordinateBounds(sw: destinationCoor, ne: originCoor)
            
            //The inset distances for views
            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            
            //Returns the camera that best fits the given coordinate bounds, optionally with some additional padding on each side
            let routeCam = self.mapView.cameraThatFitsCoordinateBounds(coordinateBounds, edgePadding: insets)
            
            //Moves the viewpoint to a different location with respect to the map with an optional transition animation
            self.mapView.setCamera(routeCam, animated: true)
            
        })
    }
}



