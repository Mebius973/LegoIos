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
    private var _searchResults = [SearchResult]()

    func searchResultAt(index: Int) -> SearchResult {
        return _searchResults[index]
    }

    func searchHint(_ query: String, _ closure: (() -> Void)?) {
        search(itemQuantity: 10, query, closure)
    }

    func searchFull(_ query: String, _ closure: (() -> Void)?) {
        search(itemQuantity: nil, query, closure)
    }

    private func search(itemQuantity: Int?, _ query: String, _ closure: (() -> Void)?) {
        _searchResults.removeAll()
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var params = "?search=\(encodedQuery)&\(authorization)"
        if let itemsPerPage = itemQuantity {
            params = "\(params)&page_size=\(itemsPerPage)"
        }

        let request = "\(baseUrl)\(params)"
        let url: URL = URL(string: request)!

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                if (response as? HTTPURLResponse)!.statusCode != 200 {
                    throw GarbageErrors.httpBadResult
                }
                let data = data!
                let jsonDecoder = JSONDecoder()
                let setsQueryResult = try jsonDecoder.decode(SetsQueryResult.self, from: data)
                for set in setsQueryResult.results! {
                    if let name = set.name, let num = set.setNum {
                        self._searchResults.append(SearchResult(name: name, num: num))
                    }
                }
                if closure != nil {
                   closure!()
               }
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }
}
