//
//  SetViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetViewController: UIViewController, UISetCellDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var setNameLabel: UILabel!
    @IBOutlet weak var setYearLabel: UILabel!
    @IBOutlet weak var setCategoryLabel: UILabel!
    @IBOutlet weak var setPartsLabel: UILabel!
    @IBOutlet weak var setSetNumLabel: UILabel!

    private var _setCell: SetCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUIElements()
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }

    private func updateUIElements() {
        if let setCell = _setCell {
            image.image = setCell.image
            setNameLabel.text = setCell.set.name
            if let year = setCell.set.year {
                setYearLabel.text = String(year)
            }
            if let themeId = setCell.set.themeId {
                setCategoryLabel.text = String(themeId)
            }
            if let numParts = setCell.set.numParts {
                setPartsLabel.text = String(numParts)
            }
            setSetNumLabel.text = setCell.set.setNum
        }
    }
}
