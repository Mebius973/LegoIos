//
//  SetViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetDetailsViewController: UIViewController, UISetCellDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var setNameLabel: UILabel!
    @IBOutlet weak var setYearLabel: UILabel!
    @IBOutlet weak var setCategoryLabel: UILabel!
    @IBOutlet weak var setPartsLabel: UILabel!
    @IBOutlet weak var setSetNumLabel: UILabel!
    @IBOutlet weak var setCategorySpinner: UIActivityIndicatorView!

    private var _setCell: SetCell?
    private var _viewModel: SetDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUIElements()
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
        _viewModel = SetDetailsViewModel(viewController: self, setCell: _setCell!)
    }

    func setDetailsUpdated(setDetails: SetDetails) {
        DispatchQueue.main.async {
            self.updateUIElements()
            if let themeName = setDetails.theme!.name {
                self.setCategorySpinner.stopAnimating()
                self.setCategoryLabel.text = themeName
                self.setCategoryLabel.isHidden = false
            }
        }
    }

    private func updateUIElements() {
        if let setCell = _setCell {
            image.image = setCell.image
            if let set = setCell.set {
                setNameLabel.text = set.name
                if let year = set.year {
                    setYearLabel.text = String(year)
                }
                if let numParts = set.numParts {
                    setPartsLabel.text = String(numParts)
                }
                setSetNumLabel.text = set.setNum
            }
            setCategoryLabel.isHidden = true
            setCategorySpinner.startAnimating()
        }
    }
}