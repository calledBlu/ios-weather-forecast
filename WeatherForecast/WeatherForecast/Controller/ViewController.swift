//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var userAddress: String?
    private var currentWeather: WeatherData?
    private var forecastWeathers: [WeatherData]?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        registerCollectionViewCell()
        configureAutoLayout()
    }
    
    private func registerCollectionViewCell() {
        collectionView.register(CurrentWeatherCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrentWeatherCell.id)
        collectionView.register(ForecastWeatherCell.self, forCellWithReuseIdentifier: ForecastWeatherCell.id)
    }
    
    private func configureAutoLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    //TODO: RefreshControl 시행착오 ing🥲
//    private func setUpRefreshControl() {
//        let control = UIRefreshControl()
//        control.addTarget(self, action: #selector(refreshCollectionView), for: .allEvents)
//        collectionView.refreshControl = control
//    }
//
//    @objc func refreshCollectionView() {
//        if collectionView.refreshControl?.isRefreshing ?? false {
//            collectionView.refreshControl?.endRefreshing()
//        }
//        collectionView.refreshControl?.beginRefreshing()
//        locationManager.requestLocation()
//    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 70)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = forecastWeathers?.count else { return 40 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastWeatherCell.id, for: indexPath) as! ForecastWeatherCell
        cell.backgroundColor = .blue
        cell.icon.image = forecastWeathers?[indexPath.row].icon
        cell.timeLabel.text = forecastWeathers?[indexPath.row].dataTime
        cell.temperatureLabel.text = forecastWeathers?[indexPath.row].temperature
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentWeatherCell.id, for: indexPath) as! CurrentWeatherCell
        header.backgroundColor = .green
        header.view.image.image = currentWeather?.icon
        header.view.addressLabel.text = userAddress ?? "-"
        header.view.temperatureLabel.text = currentWeather?.temperature ?? "-"
        header.view.minMaxTemperatureLabel.text = "최저 \(currentWeather?.minimumTemperature ?? "-") 최고 \(currentWeather?.maximumTemperature ?? "-")" //TODO: 값 없을 때 "최저 - 최고 -" 로 뜨는 문제
        return header
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
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
        
        Task {
            updateAddress(to: location) { String(place: $0) }   // <- 이건 Task블록 밖에서 호출 가능하지만 동작은 제대로 하지 않아요(reloadData와 순서가 꼬일 때도 있어요)
            try await updateCurrentWeather(for: location)
            try await updateForecastWeathers(for: location)
            
            collectionView.reloadData()
        }
    }
    
    //TODO: 에러 정의 구체적으로!
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //MARK: 주소 업데이트
    private func updateAddress(to place: CLLocation, _ completion: @escaping (CLPlacemark) -> String?) {
        CLGeocoder().reverseGeocodeLocation(place) { [unowned self] places, error in
            guard let place = places?.first else { return }
            userAddress = completion(place)
        }
    }
    
    //MARK: 현재날씨 업데이트
    private func updateCurrentWeather(for location: CLLocation) async throws {
        let current = try await WeatherParser<CurrentWeatherComponents>.parseWeatherData(at: CurrentCoordinate(of: location))
        currentWeather = WeatherData(current: current)
        try await currentWeather?.iconCodeToIcon { [unowned self] image in
            currentWeather?.icon = image
        }
    }
    
    //MARK: 미래날씨 업데이트
    private func updateForecastWeathers(for location: CLLocation) async throws {
        let forecast = try await WeatherParser<ForecastWeatherComponents>.parseWeatherData(at: CurrentCoordinate(of: location))
        forecastWeathers = forecast.list.map { WeatherData(forecast: $0) }
        for (index, weatherData) in forecastWeathers!.enumerated() {
            var image: UIImage?
            try await weatherData.iconCodeToIcon { image = $0 }
            forecastWeathers?[index].icon = image
        }
    }
}
