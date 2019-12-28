//
//  Theme.swift
//  LegoIos
//
//  Created by Mebius on 28/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class Theme: Codable {
    let themeId: Int?
    let parentId: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case themeId = "id"
        case parentId = "parent_id"
        case name = "name"
    }
}
