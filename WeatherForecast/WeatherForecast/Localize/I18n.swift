//
//  I18n.swift
//  WeatherForecast
//
//  Created by J.E on 2023/05/01.
//

import Foundation

struct I18n {
    struct CellText {
        static let weather = "weather".localized
    }
    
    struct HeaderText {
        static let address = "address".localized
        static let (minTemp, maxTemp) = ("minTemp".localized, "maxTemp".localized)
    }
}
