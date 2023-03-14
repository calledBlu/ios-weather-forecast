//
//  WeatherForecastTests - WeatherForecastTests.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
//    var sut: DataFetchingModel<CurrentWeatherModel>!
//    var sut2: DataFetchingModel<FiveDaysWeatherModel>!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        sut = DataFetchingModel()
//        sut2 = DataFetchingModel()
//    }
//
//    override func tearDownWithError() throws {
//        try super.tearDownWithError()
//        sut = nil
//        sut2 = nil
//    }
//
//    func test_날씨타입에_맞게_주소를_가져오는지() {
//        // given
//        let currentWeatherType = WeatherType.current
//        let fiveDaysWeatherType = WeatherType.fiveDays
//        let coordinate = Coord(lon: 126.96, lat: 37.53)
//
//        // when
//        let currentWeatherURL = WeatherURL.make(at: coordinate, weatherType: currentWeatherType)
//        let fiveDaysWeatherURL = WeatherURL.make(at: coordinate, weatherType: fiveDaysWeatherType)
//        let currentWeatherURLResult = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.53&lon=126.96&appid=33f6d884e30621345ee893c404cd9866")
//        let fiveDaysWeatherURLResult = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=37.53&lon=126.96&appid=33f6d884e30621345ee893c404cd9866")
//
//        // then
//        XCTAssertEqual(currentWeatherURL, currentWeatherURLResult)
//        XCTAssertEqual(fiveDaysWeatherURL, fiveDaysWeatherURLResult)
//    }

//    func test_모델타입에_맞춰_데이터가_변환되는지() async throws {
//        // given
//        let currentWeatherType = WeatherType.current
//        let fiveDaysWeatherType = WeatherType.fiveDays
//        let coordinate = Coord(lon: 126.96, lat: 37.53)
//
//        // when
//        let currentWeather = try await DataFetchingModel<CurrentWeatherModel>.fetchWeatherData(for: currentWeatherType, at: coordinate)
//
//        print(currentWeather)
//        let fiveDaysWeather = try await DataFetchingModel<FiveDaysWeatherModel>.fetchWeatherData(for: fiveDaysWeatherType, at: coordinate)
//
//
//        print(fiveDaysWeather)
//
//        // then
//
//    }
}
