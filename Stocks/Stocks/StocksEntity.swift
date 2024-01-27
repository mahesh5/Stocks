//
//  StocksEntity.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import Foundation

struct Stock {
    let ticker: String
    let companyName: String
    var price: Double
    var change: Double
    var changePercentage: Double
    var marketCap: String
}

struct Delta {
    var price: Double
    var change: Double
    var changePercentage: Double
}


