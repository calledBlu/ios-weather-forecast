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
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Expected \(Self.self) initialization did fail")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.stackView.subviews.forEach { ($0 as? UILabel)?.text = nil }
    }
    
    private func configureCell() {
        var contentConfig = UIListContentConfiguration.cell()
        self.contentConfiguration = contentConfig
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .clear
        self.backgroundConfiguration = backgroundConfig
    }
}
