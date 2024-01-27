//
//  GraphViewController.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import UIKit

class GraphViewController: UIViewController {
    var delta: [Double]?
    var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Graph"
        self.view.backgroundColor = .white
        let graphWidth: CGFloat = 200
        let graphHeight: CGFloat = 200
        let graphX = view.bounds.midX - graphWidth / 2
        let graphY = view.bounds.midY - graphHeight / 2
        
        let graphFrame = CGRect(x: graphX, y: graphY, width: graphWidth, height: graphHeight)
        let graphView = GraphView(frame: graphFrame, dataPoints: delta ?? [], selectedIndex: selectedIndex ?? 0)
        view.addSubview(graphView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
