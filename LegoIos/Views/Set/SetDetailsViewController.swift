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
    @IBOutlet weak var setCategorySpinner: UIActivityIndicatorView!

    private var _spinner = UIActivityIndicatorView(frame: CGRect(
        x: 0,
        y: 0,
        width: 40,
        height: 40
    ))
    private var _setNum: String?
    private var _viewModel: SetDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSpinner()
    }

    func configure(with setNum: String) {
        self._setNum = setNum
        _viewModel = SetDetailsViewModel(viewController: self, setNum: setNum)
    }

    func setDetailsUpdated(setDetails: SetDetails) {
        DispatchQueue.main.async {
            self.updateUIElements(setDetails: setDetails)
        }
    }

    private func addSpinner() {
        _spinner.center = self.view.center
        _spinner.hidesWhenStopped = true
        _spinner.backgroundColor = .systemBackground
        _spinner.bounds = self.view.bounds
        _spinner.startAnimating()
        self.view.addSubview(_spinner)
    }

    private func updateUIElements(setDetails: SetDetails) {
        if let setCell = setDetails.setCell {
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
            if let themeName = setDetails.theme!.name {
                self.setCategoryLabel.text = themeName
            }
        }
        _spinner.stopAnimating()
    }
}
