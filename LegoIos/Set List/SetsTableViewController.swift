//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController, UITableViewDataSourcePrefetching, UITabBarControllerDelegate {
    private var viewModel: SetsViewModel = SetsViewModel()
    private let bottomActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var tabBarItemClickedOnce = true
    private var firstTimePrefetch = true
    private var dataReloading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        prolongateLaunchScreen()

        self.tabBarController?.delegate = self
        tableView.prefetchDataSource = self
        setupPullToRefreshUI()
        addBottomActivityIndicator()

        viewModel.initializeSetCells {
            self.setsUpdated()
            self.dismissLaunchSreen()
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
            withIdentifier: "SetsTableViewCell",
            for: indexPath) as? SetsTableViewCell)!

        guard let setCell = viewModel.setCellAt(index: indexPath.row) else { return cell}

        cell.configure(with: setCell)
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !firstTimePrefetch && !dataReloading {
            if viewModel.isRefreshed {
                viewModel.fetchSetCells(range: indexPaths[0].row) {
                    self.setsUpdated()
                }
            } else {
                bottomActivityIndicator.startAnimating()
            }
        } else {
            firstTimePrefetch = false
            dataReloading = false
        }
    }
    // MARK: - Navigation

    func tabBarController(_ tabBarController: UITabBarController, didSelect: UIViewController) {
        if didSelect is SetsTableViewController {
            if tabBarItemClickedOnce {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            } else {
                tabBarItemClickedOnce = true
            }
        } else {
            tabBarItemClickedOnce = false
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "SetDetails" {
            let nextViewController = (segue.destination as? SetTabBarViewController)!
            nextViewController.configure(with: (sender as? SetsTableViewCell)!.setCell!)
        }
    }

    private func prolongateLaunchScreen() {
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        navigationController!.isNavigationBarHidden = true
        navigationController!.pushViewController(launchScreen, animated: false)
    }

    private func setupPullToRefreshUI() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(self.refreshSets(_:)), for: .valueChanged)
    }

    @objc private func refreshSets(_ sender: Any) {
        viewModel.fetchNewSetCells {
            self.setsUpdated()
        }
    }

    private func setsUpdated() {
        DispatchQueue.main.async {
            if self.refreshControl != nil && self.refreshControl!.isRefreshing { self.refreshControl!.endRefreshing()
            }
            self.bottomActivityIndicator.stopAnimating()
            self.dataReloading = true
            self.tableView.reloadData()
        }
    }

    private func dismissLaunchSreen() {
        DispatchQueue.main.async {
                self.navigationController!.isNavigationBarHidden = false
                self.navigationController!.popViewController(animated: false)
        }
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
