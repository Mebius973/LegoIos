//
//  QueryResult.swift
//  LegoIos
//
//  Created by Mebius on 07/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetsQueryResult: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Set]
}
