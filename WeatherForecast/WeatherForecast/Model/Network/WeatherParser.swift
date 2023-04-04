//
//  WeatherParser.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/15.
//

import Foundation
import UIKit

struct WeatherParser<T: WeatherComposable> {
    //TODO: URLService에서와 마찬가지로, 제네릭 및 중복로직 문제 해결을 위한 리팩토링 필요 (타입 분리 or 분기처리 로직 추가)
    static func parseWeatherData(at coordinate: CurrentCoordinate) async throws -> T {
        guard var request = requestData(for: T.weatherRange, at: coordinate) else {
            throw WeatherNetworkError.invalidRequest
        }
        
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherData = try JSONDecoder().decode(T.self, from: data)

        return weatherData
    }

    static func parseWeatherIcon(with iconCode: String) async throws -> UIImage? {
        guard var request = requestIcon(with: iconCode) else {
            throw WeatherNetworkError.invalidRequest
        }

        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherIcon = UIImage(data: data)

        return weatherIcon
    }
    
    //TODO: 위와 마찬가지로, 제네릭 및 중복로직 문제 해결을 위한 리팩토링 필요 (타입 분리 or 분기처리 로직 추가)
    static func requestData(for weather: WeatherRange, at coordinate: CurrentCoordinate) -> URLRequest? {
        return try? URLRequest(url: URLService.makeDataURL(at: coordinate, weatherRange: weather))
    }

    static func requestIcon(with iconCode: String) -> URLRequest? {
        return try? URLRequest(url: URLService.makeIconURL(with: iconCode))
    }
}
