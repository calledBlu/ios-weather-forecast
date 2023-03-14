//
//  CurrentWeatherModel.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/14.
//

import Foundation

// MARK: - CurrentWeatherModel
struct CurrentWeatherModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

