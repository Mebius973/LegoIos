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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Hanlde search terms here
        if let query = textField.text {
            _viewModel.search(query) {
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
