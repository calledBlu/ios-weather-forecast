//
//  WeatherURL.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/14.
//

import Foundation

enum WeatherURL: String {
    private static let baseURL = "https://api.openweathermap.org"
    private static let measurementUnit = "metric"
    private static let language = "kr"
    
    case data = "data/2.5"
    case icon = "img/wn"

    static func make(at coordinate: CurrentCoordinate, weatherRange: WeatherRange) throws -> URL {
        var components = URLComponents(string: baseURL)
        components?.path.append(data.rawValue)
        components?.path.append(weatherRange.description)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinate.longitude)"),
            URLQueryItem(name: "units", value: measurementUnit),
            URLQueryItem(name: "lang", value: language),
            URLQueryItem(name: "appid", value: Bundle.main.apiKey)
        ]
        
        guard let url = components?.url else {
            throw WeatherNetworkError.invalidURL
        }
        
        return url
    }
    
    static func make(icon: String) throws -> URL {
        var components = URLComponents(string: baseURL)
        components?.path.append(icon.rawValue)
        components
    }

    static func request(for weather: WeatherRange, at coordinate: CurrentCoordinate) -> URLRequest? {
        return try? URLRequest(url: make(at: coordinate, weatherRange: weather))
    }
    
    static func request(icon: String) -> URLRequest? {
        
    }
}
