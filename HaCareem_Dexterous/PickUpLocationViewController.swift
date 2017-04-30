//
//  PickUpLocationViewController.swift
//  HaCareem_Dexterous
//
//  Created by Asher Ahsan on 30/04/2017.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

protocol LocationDelegate{
    func locationSelected(location: CLLocationCoordinate2D)
}

class PickUpLocationViewController: UIViewController, GMSAutocompleteResultsViewControllerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var delegate: LocationDelegate!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    let marker = GMSMarker()
    var name: String?
    var address: String?
    var locationOfMarker = CLLocationCoordinate2D()
    var location: CLLocationCoordinate2D!
    var newLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 63, width: view.frame.width, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
        mapView.isUserInteractionEnabled = true
        mapView.delegate = self
        mapView.accessibilityElementsHidden = false
        mapView.settings.myLocationButton = true
        marker.map = mapView
        marker.tracksViewChanges = true
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 16.0)
        mapView.camera = camera
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        self.markerPlace(locationOfMarker: self.location, name: "")
        self.mapView.animate(toLocation: self.location)
        self.mapView.animate(toZoom: 16.0)
        
        print("place: ", place)
        
        delegate.locationSelected(location: place.coordinate)
    }
    
    func markerPlace(locationOfMarker: CLLocationCoordinate2D, name: String) {
        marker.position = locationOfMarker
        marker.title = name
        marker.appearAnimation = GMSMarkerAnimation.pop
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        
        newLocation = coordinate
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        delegate.locationSelected(location: newLocation)
        self.dismiss(animated: true, completion: nil)
    }
}
