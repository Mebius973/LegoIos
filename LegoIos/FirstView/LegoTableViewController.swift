//
//  LegoTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit
import Alamofire

class LegoTableViewController: UITableViewController {
    var sets = [Set]()
    

    @IBOutlet weak var mainActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainActivity.hidesWhenStopped = true
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> LegoTableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? LegoTableViewCell)!

        if let url = URL(string: sets[indexPath.row].set_img_url!) {
        if let data = try? Data(contentsOf: url) {
             //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

            // Configure the cell...
            cell.mainLabel.text = sets[indexPath.row].name
            cell.mainImage.image = UIImage(data: data)?.resizeWithScaleAspectFitMode(to: 200, resizeFramework: .uikit)
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func retrieveSets() {
        let authorization = "key=\(AppConfig.LEGO_API_KEY)"
        let request = "https://rebrickable.com/api/v3/lego/sets?ordering=-year%2C-set_num&page_size=10&\(authorization)"
        
        Alamofire.request(request).responseData { response in
            do {
                if response.result.isSuccess {
                    let data = response.data!
                    let jsonDecoder = JSONDecoder()
                    let setsQueryResult = try jsonDecoder.decode(SetsQueryResult.self, from: data)
                    self.sets = setsQueryResult.results
                    self.mainActivity.stopAnimating()
                    self.tableView.reloadData()
                }
            }
            catch{
                print("error")
            }
        }
    }
}
