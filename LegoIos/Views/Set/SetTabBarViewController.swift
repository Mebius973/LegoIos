//
//  SetTabBarViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

protocol SetTabBarDelegate: class {
    func getSetNum() -> String?
}

class SetTabBarViewController: UITabBarController, SetTabBarDelegate {
    func getSetNum() -> String? {
        return setNum
    }

    var setNum: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let controllers = self.viewControllers {
            for controller in controllers where controller is SetViewController {
                (controller as? SetViewController)!.setTabBarController = self
            }
        }
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
