//
//  SetTabBarViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetTabBarViewController: UITabBarController, SetTabBarDelegate, UISetCellDelegate {
    private var _setCell: SetCell? {
        didSet {
            if let controllers = self.viewControllers {
                for controller in controllers where controller is UISetCellDelegate {
                    (controller as? UISetCellDelegate)!.configure(with: _setCell!)
                }
            }
        }
    }

    func getSetCell() -> SetCell? {
        return _setCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }
}
