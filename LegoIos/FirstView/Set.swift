//
//  File.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation
import SwiftyJSON

class Set {
    var imgUrl:String
    var name:String
    
    init(json:JSON){
        imgUrl = json["set_img_url"].rawString()!
        name = json["name"].rawString()!
    }
    
    init(){
        imgUrl = "default"
        name = "default"
    }
}
