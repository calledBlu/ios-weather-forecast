//
//  String+.swift
//  WeatherForecast
//
//  Created by J.E on 2023/03/31.
//

import Foundation
import CoreLocation

extension String {
    //MARK: 뷰에 띄울 일시
    init(utcTime: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(utcTime))
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM/dd(EE) HH시"
        self = formatter.string(from: date)
    }
    
    //MARK: 뷰에 띄울 주소 - '탈출'로 인해 제대로 동작하지 않는 코드 - 기록을 위해 남깁니당
//    init(place: CLLocation, _ completion: @escaping (String) -> Void) {
//        var address = ""
//        CLGeocoder().reverseGeocodeLocation(place) { places, error in
//            guard let place = places?.first,
//                  let administrativeArea = place.administrativeArea,
//                  let thoroughfare = place.thoroughfare else { return }
//            address = administrativeArea + " " + thoroughfare
//            completion(address)
//        }
//        self = address
//    }
    
    //MARK: 뷰에 띄울 주소
    init?(place: CLPlacemark) {
        guard let administrativeArea = place.administrativeArea,
              let thoroughfare = place.thoroughfare else { return nil }
        self = administrativeArea + " " + thoroughfare
    }
    
    //MARK: 뷰에 띄울 기온
    init(temperature: Double) {
        self = "\(temperature)°"
    }
}
