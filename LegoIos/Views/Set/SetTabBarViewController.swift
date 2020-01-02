//
//  SetTabBarViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetTabBarViewController: UITabBarController, SetTabBarDelegate, UISetDelegate {
    private var _setNum: String? {
        didSet {
            if let controllers = self.viewControllers {
                for controller in controllers where controller is UISetDelegate {
                    (controller as? UISetDelegate)!.configure(with: _setNum!)
                }
            }
        }
    }

    func getSetNum() -> String? {
        return _setNum
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configure(with setNum: String) {
        self._setNum = setNum
    }
}
