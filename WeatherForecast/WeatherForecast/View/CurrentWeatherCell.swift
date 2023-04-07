//
//  CurrentWeatherCell.swift
//  WeatherForecast
//
//  Created by J.E on 2023/04/03.
//

import UIKit

final class CurrentWeatherCell: UICollectionViewListCell {
    static let id = "current"
    let view = HeaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
//            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Expected \(Self.self) initialization did fail")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.stackView.subviews.forEach { ($0 as? UILabel)?.text = nil }
    }
}
