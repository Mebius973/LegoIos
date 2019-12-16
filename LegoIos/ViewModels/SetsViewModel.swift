//
//  SetsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

protocol SetsViewModelDelegate: AnyObject {
    var isInitialized: Bool { get }
    var isRefreshed: Bool { get }
    var count: Int { get }
    func nameFor(row: Int) -> String?
    func urlFor(row: Int) -> String?
    func setNumFor(row: Int) -> String?
    func initializeSets(_ closure: (() -> Void)?)
    func refreshSets(_ closure: (() -> Void)?)
}

extension SetsViewModelDelegate {
    func initializeSets() {
        initializeSets(nil)
    }
    func refreshSets() {
        refreshSets(nil)
    }
}

class SetsViewModel: SetsViewModelDelegate {
    var isInitialized = false
    var isRefreshed = false
    var count: Int {
        return sets.count
    }
    private var sets = [Set]()
    private var offset = 0
    private var page = 1
    private let itemsPerPage = 10
    private var infiniteScrollCellNumTrigger = 9

    func nameFor(row: Int) -> String? {
        guard sets.count > row else {
            return nil
        }
        return sets[row].name
    }

    func urlFor(row: Int) -> String? {
        guard sets.count > row else {
            return nil
        }
        return sets[row].setImgUrl
    }

    func setNumFor(row: Int) -> String? {
        guard sets.count > row else {
            return nil
        }
        return sets[row].setNum
    }

    func initializeSets(_ closure: (() -> Void)? = nil) {
        isInitialized = false
        retrieveSets(closure)
    }

    func refreshSets(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        retrieveSets(closure)
    }

    private func retrieveSets(_ closure: (() -> Void)? = nil) {
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "https://rebrickable.com/api/v3/lego/sets"
        let params = "?ordering=-year%2C-set_num&page_size=\(itemsPerPage)&page=\(self.page)&\(authorization)"
        let request = "\(baseUrl)\(params)"
        let url: URL = URL(string: request)!

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                if response is HTTPURLResponse {
                    let httprep = (response as? HTTPURLResponse)!
                    if httprep.statusCode == 200 {
                        let data = data!
                        let jsonDecoder = JSONDecoder()
                        let setsQueryResult = try jsonDecoder.decode(SetsQueryResult.self, from: data)
                        self.sets.append(contentsOf: setsQueryResult.results)
                        self.infiniteScrollCellNumTrigger = self.page * self.itemsPerPage * 3 / 4
                        self.page += 1
                        self.isInitialized = true
                        self.isRefreshed = true
                        if closure != nil {
                            closure!()
                        }
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }
}
