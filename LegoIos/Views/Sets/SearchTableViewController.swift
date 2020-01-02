//
//  SearchTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 02/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!

    private var _viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "SearchResult",
            for: indexPath) as? SearchTableViewCell)!

        let searchResult = _viewModel.searchResultAt(index: indexPath.row)
        cell.configure(with: searchResult)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "SearchDetails" {
            let nextViewController = (segue.destination as? SetTabBarViewController)!
            nextViewController.configure(with: (sender as? SearchTableViewCell)!.searchResult!.num)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let query = textField.text {
            _viewModel.searchHint(query) {
                self.searchEnded()
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Hanlde search terms here
        if let query = textField.text {
            _viewModel.searchFull(query) {
                self.searchEnded()
            }
        }
    }

    private func searchEnded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
