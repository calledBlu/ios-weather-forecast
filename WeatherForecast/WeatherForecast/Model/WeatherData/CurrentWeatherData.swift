//
//  CurrentWeatherData.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/28.
//

import Foundation
import CoreLocation

struct CurrentWeatherData {
    let icon: String
    let location: String = "loading..."
    let temperature, minimumTemperature, maximumTemperature: Double
    
    init(_ weatherData: CurrentWeatherComponents) {
        self.icon = weatherData.weather.first!.icon
        self.temperature = weatherData.numericalInformation.temperature
        self.minimumTemperature = weatherData.numericalInformation.minimumTemperature
        self.maximumTemperature = weatherData.numericalInformation.maximumTemperature
    }
}

enum LocationFormatter {
    private static let geocoder = CLGeocoder()
    
    private static func parse(_ coordinate: CLLocation) async throws -> CLPlacemark {
        let names = try await geocoder.reverseGeocodeLocation(coordinate)
        return names.first!
    }
    
    static func make(_ coordinate: CLLocation) async throws -> String {
        let name = try await parse(coordinate)
        return name.administrativeArea! + " " + name.thoroughfare!
    }
}
