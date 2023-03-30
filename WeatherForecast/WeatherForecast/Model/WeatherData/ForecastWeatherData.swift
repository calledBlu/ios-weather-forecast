//
//  ForecastWeatherData.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/28.
//

import Foundation
import CoreLocation

struct ForecastWeatherData {
    let dataTime: String
    let temperature, minimumTemperature, maximumTemperature: Double
    let icon: String
    
    init(_ weatherData: WeatherInformation) {
        self.dataTime = DateFormatTranslator.changeDateFormat(weatherData.dataTime)
        self.icon = weatherData.weather.first!.icon
        self.temperature = weatherData.numericalInformation.temperature
        self.minimumTemperature = weatherData.numericalInformation.minimumTemperature
        self.maximumTemperature = weatherData.numericalInformation.maximumTemperature
    }
}

enum DateFormatTranslator {
    private static let dateFormatter = DateFormatter()
    
    static func changeDateFormat(_ utcTime: Int) -> String {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(utcTime))
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return dateFormatter.string(from: date)
    }
}

