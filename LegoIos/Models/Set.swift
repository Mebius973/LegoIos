//
//  File.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class Set: Codable, Hashable {
    static func == (lhs: Set, rhs: Set) -> Bool {
        return lhs.setNum == rhs.setNum
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.setNum)
    }

    let lastModifiedDt: String?
    let name: String?
    let numParts: Int?
    let setImgUrl: String?
    let setNum: String?
    let setUrl: String?
    let themeId: Int?
    let year: Int?

    enum CodingKeys: String, CodingKey {
        case name, year
        case lastModifiedDt = "last_modified_dt"
        case numParts = "num_parts"
        case setImgUrl = "set_img_url"
        case setNum = "set_num"
        case setUrl = "set_url"
        case themeId = "theme_id"
    }
}
