//
//  SetPartsTableViewController.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetPartsTableViewController: UITableViewController, UISetCellDelegate {
    private var _setCell: SetCell?
    private var _viewModel: SetPartsViewModel?
    private var _spinner = UIActivityIndicatorView(
        frame: CGRect(x: 0,
                      y: 0,
                      width: 40,
                      height: 40)
    )

    @IBOutlet weak var noContentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        self.noContentLabel.isHidden = true
        addSpinner()
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
        _viewModel = SetPartsViewModel(viewController: self, setCell: _setCell!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _viewModel!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
        withIdentifier: "SetPartsTableViewCell",
        for: indexPath) as? SetPartsTableViewCell)!

        // Configure the cell...
        let setPart = _viewModel!.getSetPartDetailedAt(index: indexPath.row)
        cell.configure(with: setPart)
        return cell
    }

    func setPartsUpdated(_ setParts: [SetPartPresentable]) {
        DispatchQueue.main.async {
            self._spinner.stopAnimating()
            if self._viewModel!.count == 0 {
                self.noContentLabel.isHidden = false
            } else {
                self.noContentLabel.isHidden = true
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
    }

    private func addSpinner() {
        _spinner.hidesWhenStopped = true
        _spinner.startAnimating()
        _spinner.center = self.view.center
        _spinner.backgroundColor = .white
        self.view.addSubview(_spinner)
    }
}
