//
//  SetPartsTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetPartsTableViewController: UITableViewController, UISetDelegate {
    private var _setNum: String?
    private var _viewModel = SetPartsViewModel()
    private var _spinner = UIActivityIndicatorView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: 40,
            height: 40)
    )
    private var _noContentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        addSpinner()
        addNoContentLabel()
        _viewModel.fetchSetParts {
            self.setPartsUpdated()
        }
    }

    func configure(with setNum: String) {
        self._setNum = setNum
        self._viewModel.configure(setNum: setNum)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
        withIdentifier: "SetPartsTableViewCell",
        for: indexPath) as? SetPartsTableViewCell)!

        // Configure the cell...
        let setPart = _viewModel.getSetPartDetailedAt(index: indexPath.row)
        cell.configure(with: setPart)
        return cell
    }

    func setPartsUpdated() {
        DispatchQueue.main.async {
            self._spinner.stopAnimating()
            if self._viewModel.count == 0 {
                self._noContentLabel.isHidden = false
            } else {
                self._noContentLabel.isHidden = true
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
    }

    private func addSpinner() {
        _spinner.hidesWhenStopped = true
        _spinner.startAnimating()
        _spinner.center.x = self.view.center.x
        _spinner.center.y = self.view.center.y - 50
        _spinner.backgroundColor = .white
        self.view.addSubview(_spinner)
    }

    private func addNoContentLabel() {
        _noContentLabel.bounds = self.view.bounds
        _noContentLabel.text = "There is no parts information for this set"
        _noContentLabel.center.x = self.view.center.x
        _noContentLabel.center.y = self.view.center.y - 50
        _noContentLabel.numberOfLines = 2
        _noContentLabel.textAlignment = .center
        _noContentLabel.isHidden = true
        self.view.addSubview(_noContentLabel)
    }
}
