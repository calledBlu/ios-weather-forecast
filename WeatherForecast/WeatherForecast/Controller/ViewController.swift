//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class LocationManager: NSObject {
    static let geoCoder = CLGeocoder()
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM/dd(EE) HH"
        return formatter
    }()
    
    let locationManager = CLLocationManager()
    var timeStamp: Date?
    var coordinate: CLLocation?
    
    func date() -> String {
        return Self.dateFormatter.string(from: timeStamp!)
    }
    
    func address() -> String {
        var address = ""
        Self.geoCoder.reverseGeocodeLocation(coordinate!) { places, error in
            guard let place = places?.first else { return }
            address = place.administrativeArea! + " " + place.thoroughfare!
        }
        return address
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinate = locations.first
        timeStamp = locations.first?.timestamp
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
