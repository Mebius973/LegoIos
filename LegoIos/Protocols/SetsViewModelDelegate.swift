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
    func nameFor(row: Int) -> String?
    func urlFor(row: Int) -> String?
    func setNumFor(row: Int) -> String?
    func initializeSets(_ closure: (() -> Void)?)
    func refreshSets(_ closure: (() -> Void)?)
}
