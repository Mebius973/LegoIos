//
//  SetPartColor.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

struct SetPartColor: Codable {
    let setPartColorId: Int?
    let name, rgb: String?
    let isTrans: Bool?
    let externalIDS: ColorExternalIDS?

    enum CodingKeys: String, CodingKey {
        case name, rgb
        case setPartColorId = "id"
        case isTrans = "is_trans"
        case externalIDS = "external_ids"
    }
}

struct ColorExternalIDS: Codable {
    let brickLink, brickOwl, lego: BrickLink
    let peeron: Peeron
    let lDraw: BrickLink

    enum CodingKeys: String, CodingKey {
        case brickLink = "BrickLink"
        case brickOwl = "BrickOwl"
        case lego = "LEGO"
        case peeron = "Peeron"
        case lDraw = "LDraw"
    }
}

struct BrickLink: Codable {
    let extIDS: [Int]?
    let extDescrs: [[String]]?

    enum CodingKeys: String, CodingKey {
        case extIDS = "ext_ids"
        case extDescrs = "ext_descrs"
    }
}

struct Peeron: Codable {
    let extIDS: [JSONNull?]
    let extDescrs: [[String]]?

    enum CodingKeys: String, CodingKey {
        case extIDS = "ext_ids"
        case extDescrs = "ext_descrs"
    }
}
