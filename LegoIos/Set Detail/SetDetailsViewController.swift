//
//  SetViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetDetailsViewController: UIViewController, UISetDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var setNameLabel: UILabel!
    @IBOutlet weak var setYearLabel: UILabel!
    @IBOutlet weak var setCategoryLabel: UILabel!
    @IBOutlet weak var setPartsLabel: UILabel!
    @IBOutlet weak var setSetNumLabel: UILabel!
    @IBOutlet weak var setImageSpinner: UIActivityIndicatorView!
    @IBOutlet weak var setCategorySpinner: UIActivityIndicatorView!

    private var _setCell: SetCell?
    private var _viewModel: SetDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSpinners()
        _viewModel = SetDetailsViewModel(viewController: self, setCell: _setCell!)
        updateUIElements()
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }

    func setImageUpdated() {
        DispatchQueue.main.async {
            self.setImageSpinner.stopAnimating()
            self._setCell = self._viewModel!.getSetCell
            if self._setCell!.image != nil {
                self.image.image = self._setCell!.image
            }
        }
    }

    func setCategoryUpdated() {
        DispatchQueue.main.async {
            self.setCategorySpinner.stopAnimating()
            self._setCell = self._viewModel!.getSetCell
            self.setCategoryLabel.text = self._setCell!.category!
            self.setCategoryLabel.isHidden = false
        }
    }

    private func addSpinners() {
        setCategoryLabel.isHidden = true
        setImageSpinner.hidesWhenStopped = true
        setCategorySpinner.hidesWhenStopped = true
        setImageSpinner.startAnimating()
        setCategorySpinner.startAnimating()
    }

    private func updateUIElements() {
        if let set = _setCell!.set {
            setNameLabel.text = set.name
            setYearLabel.text = String(set.year)
            setPartsLabel.text = String(set.numParts)
            setSetNumLabel.text = set.setNum
        }
    }
}
