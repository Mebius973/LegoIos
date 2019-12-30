//
//  SetPartsQueryResult.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

struct SetPartsQueryResult: Codable {
    let count: Int?
    let next, previous: JSONNull?
    let results: [SetPartDetailed]?
}
