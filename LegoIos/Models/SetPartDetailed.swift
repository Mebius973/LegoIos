//
//  DetailedSetPart.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

struct SetPartDetailed: Codable {
    let part: SetPart?
    let color: SetPartColor?
    let quantity: Int?
    let setPartDetailedId, invPartID: Int?
    let setNum: String?
    let isSpare: Bool?
    let elementID: String?
    let numSets: Int?

    enum CodingKeys: String, CodingKey {
        case part, color, quantity
        case setPartDetailedId = "id"
        case invPartID = "inv_part_id"
        case setNum = "set_num"
        case isSpare = "is_spare"
        case elementID = "element_id"
        case numSets = "num_sets"
    }
}
