//
//  CurrentWeatherData.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/28.
//

import Foundation
import CoreLocation

protocol WeatherData {
    var weather: [Weather] { get }
    var numericalInformation: NumericalWeatherInformation { get }
    
//    var icon: String { get set }
//    var temperature: Double { get set }
//    var minimumTemperature: Double { get set }
//    var maximumTemperature: Double { get set }
}

extension WeatherData {
    var icon: String { weather.first!.icon }
    var temperature: Double { numericalInformation.temperature }
    var minimumTemperature: Double { numericalInformation.minimumTemperature }
    var maximumTemperature: Double { numericalInformation.maximumTemperature }
    
    var weather: [Weather] { self.weather }
    var numericalInformation: NumericalWeatherInformation { self.numericalInformation }
    
//    var weather: [Weather] {
//        get { self.weather }
//        set { icon = weather.first!.icon }
//    }
//    var numericalInformation: NumericalWeatherInformation {
//        get { self.numericalInformation }
//        set {
//            temperature = numericalInformation.temperature
//            minimumTemperature = numericalInformation.minimumTemperature
//            maximumTemperature = numericalInformation.maximumTemperature
//        }
//    }
}
    
//    init(current weatherData: CurrentWeatherComponents) {
//        self.icon = weatherData.weather.first!.icon
//        self.temperature = weatherData.numericalInformation.temperature
//        self.minimumTemperature = weatherData.numericalInformation.minimumTemperature
//        self.maximumTemperature = weatherData.numericalInformation.maximumTemperature
//    }
//
//    init(forecast weatherData: WeatherInformation) {
//        self.icon = weatherData.weather[0].icon
//        self.temperature = weatherData.numericalInformation
//    }


//struct CurrentWeatherData {
//    let icon: String
//    let location: String = "loading..."
//    let temperature, minimumTemperature, maximumTemperature: Double
//    
//    init(_ weatherData: CurrentWeatherComponents) {
//        self.icon = weatherData.weather.first!.icon
//        self.temperature = weatherData.numericalInformation.temperature
//        self.minimumTemperature = weatherData.numericalInformation.minimumTemperature
//        self.maximumTemperature = weatherData.numericalInformation.maximumTemperature
//    }
//}
//
//enum LocationFormatter {
//    private static let geocoder = CLGeocoder()
//    
//    private static func parse(_ coordinate: CLLocation) async throws -> CLPlacemark {
//        let names = try await geocoder.reverseGeocodeLocation(coordinate)
//        return names.first!
//    }
//    
//    static func make(_ coordinate: CLLocation) async throws -> String {
//        let name = try await parse(coordinate)
//        return name.administrativeArea! + " " + name.thoroughfare!
//    }
//}
