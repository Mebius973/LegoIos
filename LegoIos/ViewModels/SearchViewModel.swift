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
        return searchResults.count
    }
    private var searchResults = [String]()

    func search(_ query: String, _ closure: (() -> Void)?) {

    }
}
