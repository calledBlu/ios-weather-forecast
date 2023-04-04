//
//  CommonWeatherComponents.swift
//  WeatherForecast
//
//  Created by J.E on 2023/03/14.
//

import Foundation
import CoreLocation

struct CurrentCoordinate: Decodable {
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    //MARK: 이니셜라이저 추가 - 불가피하게 입출력 타입이 CLLocation 또는 CurrentLocation인 경우가 많아 변환 용이하게 하기 위함 && 그 때마다 memberwise생성자자를 쓰기엔 불필요한 라인이 많아져서 새로 정의
    init(of location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct NumericalWeatherInformation: Decodable {
    let temperature, feelsLike, minimumTemperature, maximumTemperature: Double
    let pressure, humidity: Int
    let seaLevel, grandLevel: Int?

    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case seaLevel = "sea_level"
        case grandLevel = "grnd_level"
        case temperature = "temp"
        case pressure, humidity
    }
}

struct Wind: Decodable {
    let speed: Double
    let degree: Int
    let gust: Double?

    enum CodingKeys: String, CodingKey {
        case speed, gust
        case degree = "deg"
    }
}

struct Clouds: Decodable {
    let cloudiness: Int

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}

struct System: Decodable {
    let country: String?
    let sunrise, sunset: Int?
    let partOfTheDay: DayPart?

    enum CodingKeys: String, CodingKey {
        case country, sunrise, sunset
        case partOfTheDay = "pod"
    }
}

enum DayPart: String, Decodable {
    case day = "d"
    case night = "n"
}
