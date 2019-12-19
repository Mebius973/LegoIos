//
//  SetViewController.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    weak var setTabBarController: SetTabBarViewController?
    @IBOutlet weak var mainLabel: UILabel!
    var setCell: SetCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCell = setTabBarController!.getSetCell()
        if let num = setCell!.set.setNum {
            mainLabel.text = "Set Num: \(num)"
        }
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
