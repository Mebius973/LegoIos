//
//  SetsViewModelDelegateExtensions.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

extension SetsViewModelDelegate {
    func initializeSetCells() {
        initializeSetCells(nil)
    }
    func fetchNewSetCells() {
        fetchNewSetCells(nil)
    }
    func fetchSetCells(range: Int) {
        fetchSetCells(range: range, nil)
    }
}
