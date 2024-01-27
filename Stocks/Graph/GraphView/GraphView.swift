//
//  GraphView.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    // This array will hold the data points that the graph will represent.
    var dataPoints: [Double] = []
    var selectedIndex: Int?

    // Custom initializer that accepts data points.
    init(frame: CGRect, dataPoints: [Double], selectedIndex: Int) {
        self.dataPoints = dataPoints
        self.selectedIndex = selectedIndex
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // The draw(_:) method is overridden to perform custom drawing.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext(), !dataPoints.isEmpty else { return }
        
        // 1. Normalize the data
        let maxDataPoint = dataPoints.max() ?? 0
        let normalizedDataPoints = dataPoints.map { $0 / maxDataPoint }
        
        let margin: CGFloat = 20.0
        let columnWidth = (rect.width - margin * 2) / CGFloat(dataPoints.count)
        let graphHeight = rect.height - margin * 2  // Leave some space at the top and bottom
        
        for (index, dataPoint) in normalizedDataPoints.enumerated() {
            let x = margin + CGFloat(index) * columnWidth
            let columnHeight = max(graphHeight * CGFloat(dataPoint), 2.0)  // 2.0 is the minimum column height
            let y = rect.height - margin - columnHeight  // Adjust y-position based on column height
            
            let columnRect = CGRect(x: x, y: y, width: columnWidth, height: columnHeight)
            if index == selectedIndex {
                // Set the fill color to a different color, e.g., red for the selected item
                context.setFillColor(UIColor.red.cgColor)
            } else {
                // Set the fill color to green for all other items
                context.setFillColor(UIColor.green.cgColor)
            }
            context.addRect(columnRect)
            context.fillPath()
        }
    }
}
