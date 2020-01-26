//
//  SetPart.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

struct SetPart: Codable {
    let name, partNum: String?
    let partCatID: Int?
    let partURL: String?
    let partImgURL: String?
    let externalIDS: PartExternalIDS?
    let printOf: String?

    enum CodingKeys: String, CodingKey {
        case name
        case partNum = "part_num"
        case partCatID = "part_cat_id"
        case partURL = "part_url"
        case partImgURL = "part_img_url"
        case externalIDS = "external_ids"
        case printOf = "print_of"
    }
}

struct PartExternalIDS: Codable {
    let brickOwl, lego, peeron, brickLink: [String]?
    let lDraw, brickset: [String]?

    enum CodingKeys: String, CodingKey {
        case brickOwl = "BrickOwl"
        case lego = "LEGO"
        case peeron = "Peeron"
        case brickLink = "BrickLink"
        case lDraw = "LDraw"
        case brickset = "Brickset"
    }
}
