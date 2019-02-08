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

class LocationViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    var list_postcode : String = ""
    var name : String = ""
    var pin2 = MKPointAnnotation()
    
    @IBOutlet weak var nameLabel: UITextView!
    @IBAction func backtolist(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var segmentedcontrol : UISegmentedControl!
    
    @IBOutlet weak var goBtn: UIButton!
    
    @IBAction func goMap(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Map app", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
        }
        let appleAction = UIAlertAction(title: "Default", style: .default) { (action) in
            let currentLocation = MKMapItem.forCurrentLocation()
            currentLocation.name = "My Location"
            print(self.pin2.coordinate)
            let toLocation = MKMapItem.init(placemark: MKPlacemark.init(coordinate: self.pin2.coordinate, addressDictionary: nil))
            toLocation.name = self.name
            MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:true])
        }
        if UIApplication.shared.canOpenURL(URL(string: "http://www.google.com/maps")!)
        {
            let googleAction = UIAlertAction(title: "Google Map", style: .default) { (action) in
                let lat = Double(self.pin2.coordinate.latitude)
                let lon = Double(self.pin2.coordinate.longitude)
//                let urlString = "https://www.google.com/maps/search/\(lat),\(lon)/"
                let urlString = "https://www.google.com/maps/search/\(self.name)"
                let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: true]
                UIApplication.shared.open(URL(string:escapedString!)!, options: options, completionHandler: nil)
            }
            alertController.addAction(googleAction)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(appleAction)
        self.present(alertController, animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = name
        self.nameLabel.isEditable = false
        self.goBtn.layer.cornerRadius = 40
        self.goBtn.clipsToBounds = true
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        self.map.delegate = self
        self.map.showsUserLocation = true
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(list_postcode) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
            let pin = MKPointAnnotation()
            pin.coordinate.latitude = lat!
            pin.coordinate.longitude = lon!
            pin.title = self.name
            self.map.addAnnotation(pin)
            self.pin2 = pin
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
//        let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region : MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
//        map.setRegion(region, animated: true)
//        let pin = MKPointAnnotation()
//        pin.coordinate.latitude = location.coordinate.latitude
//        pin.coordinate.longitude = location.coordinate.longitude
//        pin.title = "Your moving line"
//        self.map.addAnnotation(pin)
//    }
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
