//
//  LocationViewController.swift
//  SingaporeYelp
//
//  Created by Sophia on 7/2/19.
//  Copyright © 2019 Lynne. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import CoreLocation

class Location2ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    var list_postcode : String = ""
    var name : String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func backtolist(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    var locationManager = CLLocationManager()
    var regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var segmentedcontrol : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = name
        
        checkLocationServices()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location , latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func startTackingUserLocation(){
        map.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: map)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    
    @IBAction func segmentchanged(_ sender : AnyObject){
        switch segmentedcontrol.selectedSegmentIndex{
        case 0:
            map.mapType = MKMapType.standard
            break
        case 1:
            map.mapType = MKMapType.satellite
            break
        case 2:
            map.mapType = MKMapType.hybrid
            break
        case 3:
            map.mapType = MKMapType.satelliteFlyover
            break
        case 4:
            map.mapType = MKMapType.hybridFlyover
            break
        default:
            break
        }
    }
}
