//
//  APIDelegate.swift
//  LegoIos
//
//  Created by Mebius on 10/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation

protocol APIDelegate: class {
    func search(itemQuantity: Int?,
                _ query: String,
                _ closure: @escaping (([SetCell]) -> Void)) -> URLSessionDataTask
    func retrievePartsFor(setCell: SetCell, _ closure: @escaping (([SetPartCell]) -> Void))
    func retrieveCategoryFor(setPart: SetPartCell, _ closure: @escaping ((String?) -> Void))
    func retrieveCategory(setCell: SetCell, _ closure: @escaping ((String?) -> Void))
    func retrieveSetCells(range: Int?,
                          itemsPerPage: Int,
                          initPage: Int,
                          _ closure: @escaping ((Bool, Int, [SetCell]) -> Void))
    func retrieveNewSetCells(itemsPerPage: Int,
                             count: Int,
                             initSetCells: [SetCell],
                             _ closure: @escaping ((Bool, Int, [SetCell]) -> Void))
}
