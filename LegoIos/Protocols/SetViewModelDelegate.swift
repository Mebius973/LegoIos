//
//  SetViewModelDelegate.swift
//  LegoIos
//
//  Created by Mebius on 26/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

protocol SetViewModelDelegate: class {
    func getSetDetails(setCell: SetCell) -> SetDetails
}
