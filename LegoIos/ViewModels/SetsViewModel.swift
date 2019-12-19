//
//  SetsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetsViewModel: SetsViewModelDelegate {
    var isInitialized = false
    var isRefreshed = false
    var count: Int {
        return setCells.count
    }
    private var setCells = [SetCell]()
    private var offset = 0
    private var page = 1
    private let itemsPerPage = 10
    private var infiniteScrollCellNumTrigger = 9

    func setCellAt(index: Int) -> SetCell? {
        guard setCells.count > index else {
            return nil
        }
        return setCells[index]
    }

    func initializeSetCells(_ closure: (() -> Void)? = nil) {
        isInitialized = false
        retrieveSetCells(closure)
    }

    func refreshSetCells(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        retrieveSetCells(closure)
    }

    private func retrieveSetCells(_ closure: (() -> Void)? = nil) {
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
                        for set in setsQueryResult.results {
                            self.setCells.append(SetCell(set: set, image: UIImageService.retrieveImage(for: set)))
                        }
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
