//
//  FirstViewController.swift
//  LegoIos
//
//  Created by Mebius on 17/10/2018.
//  Copyright © 2018 Mebius. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let authorization = "key=\(AppConfig.LEGO_API_KEY)"
        
        Alamofire.request("https://rebrickable.com/api/v3/lego/sets?page=last&page_size=10&ordering=year&\(authorization)").responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                print(json)
            }
        }
    }
}

