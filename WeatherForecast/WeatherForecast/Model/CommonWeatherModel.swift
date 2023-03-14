//
//  CommonWeatherModel.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/14.
//

import Foundation

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let description: Description
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel, grndLevel: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

