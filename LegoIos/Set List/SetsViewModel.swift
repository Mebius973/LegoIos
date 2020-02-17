//
//  SetsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetsViewModel {
    var isRefreshed = false
    var count: Int {
        return _setCells.count
    }
    private var _setCells = [SetCell]()
    private var _offset = 0
    private var _page = 1
    private let _itemsPerPage = 15
    private var _api: APIDelegate

    init() {
        _api = API()
    }

    init(api: APIDelegate) {
        _api = api
    }

    func setCellAt(index: Int) -> SetCell? {
        guard _setCells.count > index else {
            return nil
        }
        return _setCells[index]
    }

    func initializeSetCells() {
        initializeSetCells(nil)
    }
    func fetchNewSetCells() {
        fetchNewSetCells(nil)
    }
    func fetchSetCells(range: Int) {
        fetchSetCells(range: range, nil)
    }

    func initializeSetCells(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        _api.retrieveSetCells(range: nil, itemsPerPage: _itemsPerPage, initPage: _page) { refreshed, page, setCells in
            self.isRefreshed = refreshed
            self._page = page
            self._setCells = setCells
            if closure != nil {
                closure!()
            }
        }
    }

    func fetchSetCells(range: Int, _ closure: (() -> Void)?) {
        isRefreshed = false
        _api.retrieveSetCells(range: range, itemsPerPage: _itemsPerPage, initPage: _page) { refreshed, page, setCells in
            self.isRefreshed = refreshed
            self._page = page
            let setNums = self._setCells.map({ $0.set!.setNum })
            self._setCells.append(contentsOf: setCells.filter({ !setNums.contains($0.set!.setNum) }))
            if closure != nil {
                closure!()
            }
        }
    }

    func fetchNewSetCells(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        _api.retrieveNewSetCells(itemsPerPage: _itemsPerPage,
        count: count,
        initSetCells: _setCells) { refreshed, page, setCells in
            self.isRefreshed = refreshed
            self._page = page
            var newSetCell = [SetCell]()
            var setCells = setCells
            while setCells.count != 0 && self._setCells.count != 0 {
                newSetCell.append(setCells.first!)
                if self._setCells.first!.set!.setNum! == setCells.first!.set!.setNum! {
                    self._setCells.removeFirst()
                }
                setCells.removeFirst()
            }
            if setCells.count != 0 {
                newSetCell.append(contentsOf: setCells)
            }
            if self._setCells.count != 0 {
                newSetCell.append(contentsOf: self._setCells)
            }
            self._setCells = newSetCell
            if closure != nil {
                closure!()
            }
        }
    }
}
