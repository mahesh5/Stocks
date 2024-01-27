//
//  StockTableViewCell.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import Foundation
import UIKit

class StockTableViewCell: UITableViewCell {
    static let identifier = "StockTableViewCell"
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chgPercentage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowVisualLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(symbolLabel)
        addSubview(companyNameLabel)
        addSubview(arrowVisualLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(chgPercentage)
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            companyNameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4),
            companyNameLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
            companyNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            
            arrowVisualLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowVisualLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            changeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            changeLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -16),
            
            chgPercentage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chgPercentage.trailingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: -16)
        ])
    }
    
    func configure(with stock: Stock) {
        let change = formattedChange(stock.change).replacingOccurrences(of: "-", with: "")
        symbolLabel.text = stock.ticker
        companyNameLabel.text = stock.companyName
        chgPercentage.text = change
        priceLabel.text =  formattedChange(stock.price)
        changeLabel.text = formattedChange(stock.changePercentage)
        updateArrowVisual(forChange: change)
    }
    
    private func updateArrowVisual(forChange change: String) {
        let arrowDown = "↓"
        let arrowUp = "↑"
        if change.first == "0" {
            arrowVisualLabel.text = arrowDown
            arrowVisualLabel.textColor = .red
        } else {
            arrowVisualLabel.text = arrowUp
            arrowVisualLabel.textColor = .green
        }
    }
    
    private func formattedChange(_ change: Double) -> String {
        return String(format: "%.2f", abs(change))
    }
}
