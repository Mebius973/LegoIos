//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    private let mainActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    private var viewModel: SetsViewModelDelegate = SetsViewModel()
    private let bottomActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        setupPullToRefreshUI()
        addMainActivityIndicator()
        addBottomActivityIndicator()

        mainActivityIndicator.startAnimating()
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier",
            for: indexPath) as? SetsTableViewCell)!

        guard let setCell = viewModel.setCellAt(index: indexPath.row) else { return cell}

        cell.configure(with: setCell)
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if viewModel.isRefreshed {
            viewModel.fetchSetCells(range: indexPaths.count) {
                self.setsUpdated()
            }
        } else {
            bottomActivityIndicator.startAnimating()
        }
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
        viewModel.fetchNewSetCells {
            self.setsUpdated()
        }
    }

    private func setsUpdated() {
        DispatchQueue.main.async {
            if self.mainActivityIndicator.isAnimating { self.mainActivityIndicator.stopAnimating() }
            if self.refreshControl != nil && self.refreshControl!.isRefreshing { self.refreshControl!.endRefreshing() }
            self.bottomActivityIndicator.startAnimating()
            self.tableView.reloadData()
        }
    }

    private func addMainActivityIndicator() {
        mainActivityIndicator.style = UIActivityIndicatorView.Style.large
        mainActivityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
        mainActivityIndicator.backgroundColor = .white
        mainActivityIndicator.hidesWhenStopped = true
        self.view.addSubview(mainActivityIndicator)
    }

    private func addBottomActivityIndicator() {
        bottomActivityIndicator.hidesWhenStopped = true
        bottomActivityIndicator.frame = CGRect(x: CGFloat(0),
                                               y: CGFloat(0),
                                               width: tableView.bounds.width,
                                               height: CGFloat(44))
        self.tableView.tableFooterView = bottomActivityIndicator
    }
}
