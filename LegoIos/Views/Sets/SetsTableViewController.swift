//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController {
    private var mainActivity = UIActivityIndicatorView()
    private var viewModel: SetsViewModelDelegate = SetsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPullToRefreshUI()
        addActivityIndicator()

        mainActivity.startAnimating()
        viewModel.initializeSetCells {
            self.setsUpdated()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SetsTableViewCell {
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier",
            for: indexPath) as? SetsTableViewCell)!

        guard let setCell = viewModel.setCellAt(index: indexPath.row) else { return cell}

        cell.configure(with: setCell)
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "SetDetails" {
            let nvc = (segue.destination as? SetTabBarViewController)!
            nvc.setCell = (sender as? SetsButton)!.setCell
        }
    }

    private func setupPullToRefreshUI() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshSets(_:)), for: .valueChanged)
    }

    @objc private func refreshSets(_ sender: Any) {
        viewModel.refreshSetCells {
            self.setsUpdated()
        }
    }

    private func setsUpdated() {
        DispatchQueue.main.async {
            if self.mainActivity.isAnimating { self.mainActivity.stopAnimating() }
            if self.refreshControl != nil && self.refreshControl!.isRefreshing { self.refreshControl!.endRefreshing() }
            self.tableView.reloadData()
        }
    }

    private func addActivityIndicator() {
        mainActivity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        mainActivity.style = UIActivityIndicatorView.Style.large
        mainActivity.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
        mainActivity.backgroundColor = .white
        mainActivity.hidesWhenStopped = true
        self.view.addSubview(mainActivity)
    }
}
