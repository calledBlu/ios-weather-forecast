//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
//            let currentWeatherData = try await DataFetchingModel.fetchCurrentWeatherData(at: Coord(lon: 126.96, lat: 37.53))
//            print(currentWeatherData)
//            let FiveDaysWeatherData = try await DataFetchingModel.fetchFiveDaysWeatherData( at: Coord(lon: 126.96, lat: 37.53))
//            print(FiveDaysWeatherData)
            let data = try await RefactorDataFetchingModel<CurrentWeatherModel>.fetchCurrentWeatherData(for: .current, at: Coord(lon: 126.96, lat: 37.53))
            print(data)
        }
    }


}

