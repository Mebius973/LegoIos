//
//  SetsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 16/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetsViewModel: SetsViewModelDelegate {
    var isRefreshed = false
    var count: Int {
        return setCells.count
    }
    private var setCells = [SetCell]()
    private var offset = 0
    private var page = 1
    private let itemsPerPage = 15

    func setCellAt(index: Int) -> SetCell? {
        guard setCells.count > index else {
            return nil
        }
        return setCells[index]
    }

    func initializeSetCells(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        retrieveSetCells(closure)
    }

    func fetchSetCells(range: Int, _ closure: (() -> Void)?) {
        isRefreshed = false
        retrieveSetCells(range: range, closure)
    }

    func fetchNewSetCells(_ closure: (() -> Void)? = nil) {
        isRefreshed = false
        retrieveNewSetCells(closure)
    }

    private func computePagination(_ range: Int?) -> Int {
        guard range != nil else { return 0 }
        return range! / itemsPerPage + (range! % itemsPerPage == 0 ? 0 : 1)
    }

    private func retrieveSetCells(range: Int? = nil, _ closure: (() -> Void)? = nil) {
        let pages = computePagination(range) + self.page
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)"

        for page in self.page...pages {
            let params = "?\(Constants.SetsDefaultParams)&page_size=\(itemsPerPage)&page=\(page)&\(authorization)"
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
                            for set in setsQueryResult.results! {
                                self.setCells.append(
                                    SetCell(
                                        set: set,
                                        image: UIImageService.retrieveImage(for: set.setImgUrl!)
                                    )
                                )
                            }
                            if page == pages {
                                self.isRefreshed = true
                                if closure != nil {
                                    closure!()
                                }
                            }
                            self.page += 1
                        }
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
        }
    }

    private func retrieveNewSetCells(_ closure: (() -> Void)? = nil) {
        var duplicated = false
        var currentPage = 1
        var queryNotRunning = true
        while !duplicated && queryNotRunning {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "https://rebrickable.com/api/v3/lego/sets"
            let params = "?ordering=-year%2C-set_num&page_size=\(itemsPerPage)&page=\(currentPage)&\(authorization)"
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
                    var setNumArray = self.setCells.map { $0.set!.setNum }
                    for set in setsQueryResult.results! {
                        if !setNumArray.contains(set.setNum) {
                            self.setCells.append(SetCell(set: set,
                                                         image: UIImageService.retrieveImage(for: set.setImgUrl!)))
                            setNumArray.append(set.setNum)
                        } else {
                            duplicated = true
                            self.page = self.count / self.itemsPerPage + 1
                            self.isRefreshed = true
                            if closure != nil {
                                closure!()
                            }
                        }
                    }
                    currentPage += 1
                    queryNotRunning = true
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
            queryNotRunning = false
        }
    }
}

enum GarbageErrors: Error {
    case httpBadResult
}
