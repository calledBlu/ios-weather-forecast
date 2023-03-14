//
//  DataFetchingModel.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/14.
//

import Foundation

enum WeatherType: CustomStringConvertible {
    case current
    case fiveDays

    var description: String {
        switch self {
        case .current:
            return "weather"
        case .fiveDays:
            return "forecast"
        }
    }
}

enum WeatherURL {
    private static let baseURL = "https://api.openweathermap.org/data/2.5/"
    private static let apiKey = "33f6d884e30621345ee893c404cd9866"

    static func make(at coordinate: Coord, weatherType: WeatherType) -> URL {
        let longitude = coordinate.lon
        let latitude = coordinate.lat
        let fullURLString = "\(baseURL)\(weatherType.description)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"

        return URL(string: fullURLString)!
    }

    static func weatherURLRequest(for weather: WeatherType, at coordinate: Coord) -> URLRequest {
        return URLRequest(url: make(at: coordinate, weatherType: weather))
    }
}

struct DataFetchingModel {
    static func fetchCurrentWeatherData(at coordinate: Coord) async throws -> CurrentWeatherModel {
        let request = WeatherURL.weatherURLRequest(for: WeatherType.current, at: coordinate)
        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherData = try JSONDecoder().decode(CurrentWeatherModel.self, from: data)

        return weatherData
    }

    static func fetchFiveDaysWeatherData(at coordinate: Coord) async throws -> FiveDaysWeatherModel {
        let request = WeatherURL.weatherURLRequest(for: WeatherType.fiveDays, at: coordinate)
        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherData = try JSONDecoder().decode(FiveDaysWeatherModel.self, from: data)

        return weatherData
    }
}

struct RefactorDataFetchingModel<T: Decodable> {
    static func fetchCurrentWeatherData(for weather: WeatherType, at coordinate: Coord) async throws -> T {
        let request = WeatherURL.weatherURLRequest(for: weather, at: coordinate)
        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherData = try JSONDecoder().decode(T.self, from: data)

        return weatherData
    }
}
