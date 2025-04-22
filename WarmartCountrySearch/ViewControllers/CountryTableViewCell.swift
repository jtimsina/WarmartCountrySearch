//
//  CountryTableViewCell.swift
//  WarmartCountrySearch
//
//  Created by Jai Timsina on 4/22/25.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    let countryLabel = UILabel()
    let countryCodeLabel = UILabel()
    let capitalLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCellLayout() {
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        countryLabel.numberOfLines = 0
        countryLabel.adjustsFontForContentSizeCategory = true

        countryCodeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        countryCodeLabel.textAlignment = .right

        capitalLabel.font = UIFont.systemFont(ofSize: 14)
        capitalLabel.textColor = .gray
        capitalLabel.numberOfLines = 1

        contentView.addSubview(countryLabel)
        contentView.addSubview(countryCodeLabel)
        contentView.addSubview(capitalLabel)

        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Align country name & region to the left
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            // Align country code to the right
            countryCodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            countryCodeLabel.centerYAnchor.constraint(equalTo: countryLabel.centerYAnchor),

            // Place capital below
            capitalLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
            capitalLabel.trailingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with country: Country) {
        countryLabel.text = "\(country.name), \(country.region)"
        countryCodeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}
