//
//  SetsViewModelDelegate.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

protocol SetsViewModelDelegate: class {
    var isInitialized: Bool { get }
    var isRefreshed: Bool { get }
    var count: Int { get }
    func setCellAt(index: Int) -> SetCell?
    func initializeSetCells(_ closure: (() -> Void)?)
    func refreshSetCells(_ closure: (() -> Void)?)
}
