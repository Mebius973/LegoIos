//
//  SetPartsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetPartsViewModel: UISetDelegate {
    var count: Int {
        return _setParts.count
    }

    private var _setCell: SetCell?
    private var _setParts = [SetPartCell]()
    private var _api: APIDelegate

    init() {
        _api = API()
    }

    init(api: APIDelegate) {
        _api = api
    }

    func configure(with setCell: SetCell) {
           _setCell = setCell
    }

    func fetchSetParts(_ closure: (() -> Void)?) {
        _api.retrievePartsFor(setCell: _setCell!) { setParts in
            self._setParts = setParts
            if closure != nil {
                closure!()
            }
        }
    }

    func getSetPartCelldAt(index: Int) -> SetPartCell {
        return _setParts[index]
    }
}
