//
//  MapViewController.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {
    //MARK:-Variables
    var latitude = ""
    var longitude = ""
    var cityName = ""
    var locationManager:CLLocationManager!
    //MARK:-Outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    //MARK:-Init
    init(latitude:String,longitude:String,cityName:String) {
        super.init(nibName: nil, bundle: nil)
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:-ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsText()
        setupMap()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mapView.reloadInputViews()
    }
    //MARK:-Functions
    private func setupMap() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    private func setLabelsText() {
        latitudeLabel.text = "Latitude \(latitude)"
        longitudeLabel.text = "Longitude \(longitude)"
        cityNameLabel.text = cityName
    }
    private func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }   
    
    //MARK:-Actions
}
extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locationManager.location?.coordinate
        location?.longitude = (CLLocationDegrees(longitude) ?? 0.0)
        location?.latitude = (CLLocationDegrees(latitude) ?? 0.0 )
        cameraMoveToLocation(toLocation: location)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (location?.latitude)!, longitude: (location?.longitude)!)
        marker.layer.backgroundColor = UIColor.black.cgColor
        marker.map = mapView
    }
}
