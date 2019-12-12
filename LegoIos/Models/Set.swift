//
//  File.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class Set: Codable {
    let lastModifiedDt: String? = nil
    let name: String? = nil
    let numParts: Int? = nil
    let setImgUrl: String? = nil
    let setNum: String? = nil
    let setUrl: String? = nil
    let themeId: Int? = nil
    let year: Int? = nil

    enum CodingKeys: String, CodingKey {
        case lastModifiedDt = "last_modified_dt"
        case numParts = "num_parts"
        case setImgUrl = "set_img_url"
        case setNum = "set_num"
        case setUrl = "set_url"
        case themeId = "theme_id"
    }
}
