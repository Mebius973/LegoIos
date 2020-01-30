//
//  SearchViewController.swift
//  LegoIos
//
//  Created by Mebius on 02/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation

class SearchViewModel {
    var count: Int {
        return _searchResults.count
    }

    private var _searchResults = [SetCell]()
    private var _searchTask: URLSessionDataTask?
    private var _api: APIDelegate

    init() {
        _api = API()
    }

    init(api: APIDelegate) {
        _api = api
    }

    func searchResultAt(index: Int) -> SetCell {
        return _searchResults[index]
    }

    func searchHint(_ query: String?, _ closure: (() -> Void)?) {
        if _searchTask != nil {
            _searchTask!.cancel()
        }
        if query == nil || query!.isEmpty {
            self._searchResults.removeAll()
            if closure != nil {
                closure!()
            }
        } else {
            _searchTask = _api.search(itemQuantity: 10, query!) { searchResults in
                self._searchResults = searchResults
                if closure != nil {
                    closure!()
                }
            }
        }
    }

    func searchFull(_ query: String?, _ closure: (() -> Void)?) {
        if _searchTask != nil {
            _searchTask!.cancel()
        }
        if query == nil || query!.isEmpty {
            self._searchResults.removeAll()
            if closure != nil {
                closure!()
            }
        } else {
            _searchTask = _api.search(itemQuantity: nil, query!) { searchResults in
                self._searchResults = searchResults
                if closure != nil {
                    closure!()
                }
            }
        }
    }
}
