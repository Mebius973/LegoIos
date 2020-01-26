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
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func searchCanceled(_ sender: Any) {
        self.calledFromCancel = true
        self.searchTextField.endEditing(true)
        self.calledFromCancel = false
    }

    private var calledFromCancel = false
    private var _viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.isEnabled = false
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

        if _viewModel.count > 0 {
            let searchResult = _viewModel.searchResultAt(index: indexPath.row)
            cell.configure(with: searchResult)
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "SearchDetails" {
            let nextViewController = (segue.destination as? SetTabBarViewController)!
            nextViewController.configure(with: (sender as? SearchTableViewCell)!.setCell!)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        _viewModel.searchHint(textField.text) {
            self.hintEnded()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Hanlde search terms here
        if !calledFromCancel {
            _viewModel.searchFull(textField.text) {
                self.searchEnded()
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cancelButton.isEnabled = true
    }

    private func hintEnded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func searchEnded() {
        hintEnded()
        DispatchQueue.main.async {
            self.cancelButton.isEnabled = false
        }
    }
}
