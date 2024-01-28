//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import Foundation
class StocksViewModel {
    private var stocks: [Stock] = []
    private var deltas: [Delta] = []
    private var currentDeltaIndex = 0
    private var currentTimers: [Double] = []
    
    init() {
        parseStockCSV()
        parseDeltaCSV()
    }

    private func parseStockCSV() {
        if let path = Bundle.main.path(forResource: "snapshot", ofType: "csv"),
           let csvString = try? String(contentsOfFile: path) {
            self.stocks = parseCSV(from: csvString)
        }
    }
    
    private func parseDeltaCSV() {
        if let path = Bundle.main.path(forResource: "deltas", ofType: "csv"),
           let csvString = try? String(contentsOfFile: path) {
            self.deltas = parseDeltasCSV(from: csvString)
        }
    }
    
    func numberOfItems() -> Int {
        return stocks.count
    }
    
    func itemAtIndex(_ index: Int) -> Stock? {
        guard index >= 0 && index < stocks.count else { return nil }
        return stocks[index]
    }
    
    func loadNextDelta() {
        guard !deltas.isEmpty else { return }
        for index in stocks.indices {
            // Map each delta to corresponding stock index
            let delta = deltas[currentDeltaIndex % deltas.count]
            stocks[index].price = delta.price
            stocks[index].change = delta.change
            stocks[index].changePercentage = delta.changePercentage
            currentDeltaIndex += 1
            // Check if we've reached the end of the deltas array
            if currentDeltaIndex >= deltas.count {
               //Reached end of deltas. Restarting from the first delta.
                currentDeltaIndex = 0 // Reset the index to start applying deltas again
                break  // Exit the loop since we're starting over
            }
        }
    }
    
    private func parseCSV(from csvString: String) -> [Stock] {
        return csvString
            .components(separatedBy: "\n")
            .compactMap { row -> Stock? in
                let columns = row.components(separatedBy: ",")
                guard columns.count == 6,
                      let price = Double(columns[2]),
                      let change = Double(columns[3]),
                      let percentage = percentageStringToDouble(columns[4]) else {
                    return nil
                }
                let stock = Stock(
                    ticker: columns[0],
                    companyName: columns[1],
                    price: price,
                    change: change,
                    changePercentage: percentage,
                    marketCap: columns[5]
                )
                return stock
            }
    }
    
    private func parseDeltasCSV(from csvString: String) -> [Delta] {
        let rows = csvString.components(separatedBy: "\n")
        var deltas = [Delta]()
        var currentTimer: Double = 0
        var stockCount = 0

        for row in rows {
            let columns = row.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            if let newTimer = columns.first.flatMap(Double.init) {
                currentTimer = newTimer
            }
            
            if columns.allSatisfy({ $0.isEmpty }) {
                deltas.append(Delta(price: 0, change: 0, changePercentage: 0))
            }  else if columns.count == 6,
                      let price = Double(columns[2]),
                      let change = Double(columns[3]),
                      let percentage = percentageStringToDouble(columns[4]) {
                let delta = Delta(price: price, change: change, changePercentage: percentage)
                deltas.append(delta)
                stockCount += 1
                 // Check if stock count limit is reached, and if so, update the timer value
                if stockCount == stocks.count {
                    currentTimers.append(currentTimer)
                    stockCount = 0
                }
            }
        }
        return deltas
    }
    
    func getDeltasForGraph() -> [Double] {
        return deltas.map { abs($0.change) }
    }
    
    func getDeltaCount() -> Int {
        return deltas.count
    }
    
     func getTimerIntervals() -> [TimeInterval] {
         let secondsArray = currentTimers.map { $0 / 1000.0 }
         return secondsArray
     }
    
    private func percentageStringToDouble(_ percentageString: String) -> Double? {
        let cleanedString = percentageString.replacingOccurrences(of: "%", with: "")
        return Double(cleanedString)
    }
}
