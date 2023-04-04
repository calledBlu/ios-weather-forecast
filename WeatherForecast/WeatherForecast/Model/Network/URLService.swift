//
//  URLService.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/14.
//

import Foundation

enum URLService: String {
    case data = "data/2.5/"
    case icon = "img/wn/"

    //TODO: 중복구간이 많은 baseURL - URLComponent를 더 활용해 url 구성요소 세분화 필요
    private static let baseURLforData = "https://api.openweathermap.org/"
    private static let baseURLforIcon = "https://openweathermap.org/"
    private static let measurementUnit = "metric"
    private static let language = "kr"

    //TODO: 마찬가지로, 가능하다면 분기처리를 통해 두 makeURL함수 통합or정리
    static func makeDataURL(at coordinate: CurrentCoordinate, weatherRange: WeatherRange) throws -> URL {
        var components = URLComponents(string: baseURLforData)
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

    static func makeIconURL(with iconCode: String) throws -> URL {
        var components = URLComponents(string: baseURLforIcon)
        components?.path.append(icon.rawValue)
        components?.path.append("\(iconCode)@2x.png")

        guard let url = components?.url else {
            throw WeatherNetworkError.invalidURL
        }

        return url
    }
}
