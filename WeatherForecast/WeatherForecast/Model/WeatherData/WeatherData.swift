//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Blu on 2023/03/28.
//

import Foundation
import UIKit

struct WeatherData {
    let dataTime: String?
    var icon: UIImage?  // <- UIImage타입 프로퍼티 추가함
    let iconCode, temperature, minimumTemperature, maximumTemperature: String
    
    //TODO: 임시로 이니셜라이저 구현 -> DTO변환 방법 예시 공부중이에요🫠
    init(current data: CurrentWeatherComponents) {
        self.dataTime = nil
        self.iconCode = data.weather[0].icon
        self.temperature = String(temperature: data.numericalInformation.temperature)
        self.minimumTemperature = String(temperature: data.numericalInformation.minimumTemperature)
        self.maximumTemperature = String(temperature: data.numericalInformation.maximumTemperature)
    }
    
    init(forecast data: WeatherInformation) {
        self.dataTime = String(utcTime: data.dataTime)
        self.iconCode = data.weather[0].icon
        self.temperature = String(temperature: data.numericalInformation.temperature)
        self.minimumTemperature = String(temperature: data.numericalInformation.minimumTemperature)
        self.maximumTemperature = String(temperature: data.numericalInformation.maximumTemperature)
    }
    
    //TODO: 네이밍 수정...
    //MARK: iconCode(String)를 icon(UIImage)으로 변환 - by 컴플리션 핸들러
    func iconCodeToIcon(_ completion: @escaping (UIImage?) -> Void) async throws {
        let image = try await WeatherParser<CurrentWeatherComponents>.parseWeatherIcon(with: iconCode)
        completion(image)
    }
}
