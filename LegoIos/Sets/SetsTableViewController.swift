//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController {
    private var sets = [Set]()
    private var images = [UIImage?]()
    private var mainActivity = UIActivityIndicatorView()

    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        // Configure Refresh Control
        self.refreshControl!.addTarget(self, action: #selector(refreshSets(_:)), for: .valueChanged)
        addActivityIndicator()
        super.viewDidLoad()
        if sets.count < 1 {
            mainActivity.startAnimating()
        } else {
            mainActivity.stopAnimating()
        }
        DispatchQueue.main.async {
            self.retrieveSets()
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
        return sets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SetsTableViewCell {
//        if indexPath ==
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier",
            for: indexPath) as? SetsTableViewCell)!

        cell.mainImage.image = images[indexPath.row]
        cell.mainLabel.text = sets[indexPath.row].name
        cell.setNum = sets[indexPath.row].setNum
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

    @objc private func refreshSets(_ sender: Any) {
        retrieveSets()
    }

    private func retrieveSets() {
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let request = "https://rebrickable.com/api/v3/lego/sets?ordering=-year%2C-set_num&page_size=10&\(authorization)"
        let url: URL = URL(string: request)!

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                if response is HTTPURLResponse {
                    let httprep = (response as? HTTPURLResponse)!
                    if httprep.statusCode == 200 {
                        let data = data!
                        let jsonDecoder = JSONDecoder()
                        let setsQueryResult = try jsonDecoder.decode(SetsQueryResult.self, from: data)
                        self.sets = setsQueryResult.results
                        self.retrieveImages()
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }

    private func retrieveImages() {
        DispatchQueue.main.async {
            for count in 0...(self.sets.count - 1) {
                if let urlString = self.sets[count].setImgUrl {
                    if let url = URL(string: urlString) {
                        if let data = try? Data(contentsOf: url) {
                            self.images.append(UIImage(data: data)?
                                .resizeWithScaleAspectFitMode(to: 200, resizeFramework: .uikit))
                        }
                    }
                }
            }
            self.imagesUpdated()
        }
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
