//
//  StockTableHeaderView.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import Foundation
import UIKit

class StockTableHeaderView: UIView {
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Company Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Price"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Chg %"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chgPercentage: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Change"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    private func setupViews() {
        self.backgroundColor = .lightText
        addSubview(companyNameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(chgPercentage)
        
        NSLayoutConstraint.activate([
            companyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            changeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            changeLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -16),
            
            chgPercentage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chgPercentage.trailingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: -16)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

