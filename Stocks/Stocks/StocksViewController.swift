//
//  ViewController.swift
//  Stocks
//
//  Created by Mahesh Varadaraj on 27/01/24.
//

import UIKit

class StocksViewController: UIViewController {
    private var viewModel = StocksViewModel()
    private let tableView = UITableView()
    private var updateTask: DispatchWorkItem?
    private var currentIndex = 0
    private var currentTimerIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stocks"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        let stockHeaderView = StockTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        tableView.tableHeaderView = stockHeaderView
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scheduleUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelScheduledUpdates()
    }
    
    private func scheduleUpdate() {
        updateTask?.cancel()
        let timerIntervals = viewModel.getTimerIntervals()
        let timerInterval = timerIntervals[currentTimerIndex % timerIntervals.count]
        
        let task = DispatchWorkItem { [weak self] in
            self?.viewModel.loadNextDelta()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

            // Move to the next item and the next timer interval
            self?.currentIndex += 1
            self?.currentTimerIndex += 1

            // Check if we've reached the end of the items list
            if self?.currentIndex ?? 0 >= self?.viewModel.deltas.count ?? 0 {
                self?.currentIndex = 0 // Reset currentIndex to loop back to the start
            }

            // Reschedule the next update
            self?.scheduleUpdate()
        }

        // Schedule the task with the current timer interval
        DispatchQueue.main.asyncAfter(deadline: .now() + timerInterval, execute: task)
        updateTask = task
    }

    private func cancelScheduledUpdates() {
        updateTask?.cancel()
        updateTask = nil
    }

}

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell, let stock = viewModel.itemAtIndex(indexPath.row) else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: stock)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController = self.navigationController {
            let graphViewController = GraphViewController()
            graphViewController.delta = viewModel.getDeltasForGraph()
            graphViewController.selectedIndex = indexPath.row
            navigationController.pushViewController(graphViewController, animated: true)
         }
    }
}
