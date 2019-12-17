//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController {
    private var images = [UIImage?]()
    private var mainActivity = UIActivityIndicatorView()
    private var viewModel: SetsViewModelDelegate = SetsViewModel()
    private var imageService: UIImageServiceDelegate = UIImageService()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPullToRefreshUI()
        addActivityIndicator()

        mainActivity.startAnimating()
        viewModel.initializeSets {
            self.imageService.retrieveImages(viewModel: self.viewModel) { images in
                self.images = images
                self.imagesUpdated()
            }
        }

        //self.tableView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20);
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let row = indexPath.row
//        if row > infiniteScrollCellNumTrigger {
//            DispatchQueue.main.async {
//                self.retrieveSets()
//            }
//        }
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier",
            for: indexPath) as? SetsTableViewCell)!

        cell.mainImage.image = images[row]
        cell.mainLabel.text = viewModel.nameFor(row: row)
        cell.setNum = viewModel.setNumFor(row: row)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array,
            // and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "SetDetails" {
            let nvc = (segue.destination as? SetTabBarViewController)!
            let setNum = (sender as? SetsButton)!.setNum
            nvc.setNum = setNum
        }
    }

    private func setupPullToRefreshUI() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshSets(_:)), for: .valueChanged)
    }

    @objc private func refreshSets(_ sender: Any) {
        viewModel.refreshSets()
    }

    private func imagesUpdated() {
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
