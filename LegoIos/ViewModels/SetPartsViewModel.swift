//
//  SetPartsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetPartsViewModel {
    var count: Int = 0

    private weak var _viewController: SetPartsTableViewController?
    private var _setCell: SetCell

    init(viewController: SetPartsTableViewController, setCell: SetCell) {
        _viewController = viewController
        _setCell = setCell
        retrieveParts()
    }

    private func retrieveParts() {

    }
}
