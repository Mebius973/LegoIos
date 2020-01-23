//
//  SetTabBarViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetTabBarViewController: UITabBarController, UISetDelegate {
    private var _setCell: SetCell? {
        didSet {
            if let controllers = self.viewControllers {
                for controller in controllers where controller is UISetDelegate {
                    (controller as? UISetDelegate)!.configure(with: _setCell!)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }
}
