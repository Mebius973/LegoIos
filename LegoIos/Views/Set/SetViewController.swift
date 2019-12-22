//
//  SetViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetViewController: UIViewController, UISetCellDelegate {
    @IBOutlet weak var mainLabel: UILabel! {
        didSet {
            if let num = _setCell!.set.setNum {
                mainLabel.text = "Set Num: \(num)"
            }
        }
    }
    private var _setCell: SetCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }
}
