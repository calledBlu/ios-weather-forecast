//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class WeatherCell: UICollectionViewCell {
    static let id = "WeatherCell"
    let label = UILabel()

    func configLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}

class JennaHeader: UICollectionViewCell {
    static let id = "Jenna"
    let label = UILabel()

    func configLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}

class ViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var currentWeather: CurrentWeatherComponents?
    private var forecastWeather: ForecastWeatherComponents?
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBlue

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.id)
        collectionView.register(JennaHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JennaHeader.id)

        configureAutoLayout()

    }

    func configureAutoLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.id, for: indexPath) as! WeatherCell
        cell.backgroundColor = .white
        cell.label.text = "\(indexPath.row)"
        cell.label.textColor = .red
        cell.configLabel()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JennaHeader.id, for: indexPath) as! JennaHeader
        cell.backgroundColor = .cyan

        cell.label.text = "헤더임미다"
        cell.label.textColor = .gray
        cell.configLabel()

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let coordinate = CurrentCoordinate(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        Task {
            currentWeather = try await WeatherParser<CurrentWeatherComponents>.parse(at: coordinate)
            forecastWeather = try await WeatherParser<ForecastWeatherComponents>.parse(at: coordinate)
            let placemark = try await geocoder.reverseGeocodeLocation(location)
            let address = placemark.description.components(separatedBy: ", ")[1]
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
