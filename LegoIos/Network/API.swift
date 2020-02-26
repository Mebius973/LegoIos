//
//  API.swift
//  LegoIos
//
//  Created by Mebius on 10/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation

class API: APIDelegate {
    private var _cache = Cache()
    private var _decoder = JSONDecoder()

    init() {
        _cache.load()
        _decoder.userInfo[CodingUserInfoKey.context!] = _cache.managedObjectContext
    }

    func search(itemQuantity: Int?,
                _ query: String,
                _ closure: @escaping (([SetCell]) -> Void)) -> URLSessionDataTask {
        var searchResults = [SetCell]()
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var params = "?search=\(encodedQuery)&\(authorization)"
        if let itemsPerPage = itemQuantity {
            params = "\(params)&page_size=\(itemsPerPage)"
        }

        let request = "\(baseUrl)\(params)"
        let url: URL = URL(string: request)!

        let searchTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard response != nil else { return }
            do {
                if response != nil && (response as? HTTPURLResponse)!.statusCode != 200 {
                    throw GarbageErrors.httpBadResult
                }
                let data = data!
                let setsQueryResult = try self._decoder.decode(SetsQueryResult.self, from: data)
                for set in setsQueryResult.results! {
                    searchResults.append(SetCell(set: set, image: nil))
                }
                self._cache.save()
                closure(searchResults)
            } catch {
                print("error: \(error)")
            }
        }
        searchTask.resume()
        return searchTask
    }

    func retrieveCategory(setCell: SetCell, _ closure: @escaping ((String?) -> Void)) {
        if let set = setCell.set {
            let categoryId = set.themeId
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.ThemesEndPoint)\(categoryId)/"
            let params = "?\(authorization)"
            let request = "\(baseUrl)\(params)"
            let url: URL = URL(string: request)!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if response is HTTPURLResponse {
                        let httprep = (response as? HTTPURLResponse)!
                        if httprep.statusCode == 200 {
                            let data = data!
                            self._cache.save()
                            closure((try self._decoder.decode(Theme.self, from: data)).name)
                        }
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
        }
    }

    func retrievePartsFor(setCell: SetCell, _ closure: @escaping (([SetPartCell]) -> Void)) {
        if let setNum = setCell.set!.setNum {
            var setParts = [SetPartCell]()
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)\(setNum)/\(Constants.PartsEndPoint)"
            let params = "?\(authorization)"
            let request = "\(baseUrl)\(params)"
            let url: URL = URL(string: request)!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if response is HTTPURLResponse {
                        let httprep = (response as? HTTPURLResponse)!
                        if httprep.statusCode == 200 {
                            let data = data!
                            let setPartsQueryResult = try self._decoder.decode(SetPartsQueryResult.self, from: data)
                            let parts = setPartsQueryResult.results!
                            for part in parts {
                                let partCell = SetPartCell()
                                partCell.setPart = part
                                setParts.append(partCell)
                            }
                            self._cache.save()
                           closure(setParts)
                        }
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
        }
    }

    func retrieveCategoryFor(setPart: SetPartCell, _ closure: @escaping ((String?) -> Void)) {
        if let categoryId = setPart.setPart!.part!.partCatID {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.PartCategoriesEndPoint)\(categoryId)/"
            let params = "?\(authorization)"
            let request = "\(baseUrl)\(params)"
            let url: URL = URL(string: request)!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if response is HTTPURLResponse {
                        let httprep = (response as? HTTPURLResponse)!
                        if httprep.statusCode == 200 {
                            let data = data!
                            let category = (try self._decoder.decode(Theme.self, from: data)).name
                            self._cache.save()
                            closure(category)
                        }
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
        }
    }

    func retrieveSetCells(range: Int?,
                          itemsPerPage: Int,
                          initPage: Int,
                          _ closure: @escaping ((Bool, Int, [SetCell]) -> Void)) {
        var currentPage = initPage
        let pages = computePagination(range, itemsPerPage) + currentPage
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)"

        var setCells = [SetCell]()
        var isRefreshed = false

        for page in currentPage...pages {
            let params = "?\(Constants.SetsDefaultParams)&page_size=\(itemsPerPage)&page=\(page)&\(authorization)"
            let request = "\(baseUrl)\(params)"
            let url: URL = URL(string: request)!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if response is HTTPURLResponse {
                        let httprep = (response as? HTTPURLResponse)!
                        if httprep.statusCode == 200 {
                            let data = data!
                            let setsQueryResult = try self._decoder.decode(SetsQueryResult.self, from: data)
                            for set in setsQueryResult.results! {
                                setCells.append(
                                    SetCell(
                                        set: set,
                                        image: UIImageService.retrieveImage(for: set.setImgUrl)
                                    )
                                )
                            }
                            if page == pages {
                                isRefreshed = true
                                self._cache.save()
                                closure(isRefreshed, pages, setCells)
                            }
                            currentPage += 1
                        }
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            task.resume()
        }
    }

    func retrieveNewSetCells(itemsPerPage: Int,
                             count: Int,
                             initSetCells: [SetCell],
                             _ closure: @escaping ((Bool, Int, [SetCell]) -> Void)) {
        var duplicated = false
        var currentPage = 1
        var queryNotRunning = true

        var setCells = initSetCells
        var isRefreshed = false

        while !duplicated && queryNotRunning {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)"
            let params = "?ordering=-year%2C-set_num&page_size=\(itemsPerPage)&page=\(currentPage)&\(authorization)"
            let request = "\(baseUrl)\(params)"
            let url: URL = URL(string: request)!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if (response as? HTTPURLResponse)!.statusCode != 200 {
                        throw GarbageErrors.httpBadResult
                    }
                    let data = data!
                    let setsQueryResult = try self._decoder.decode(SetsQueryResult.self, from: data)
                    var setNumArray = setCells.map { $0.set!.setNum }
                    for set in setsQueryResult.results! {
                        if !setNumArray.contains(set.setNum) {
                            setCells.append(SetCell(set: set,
                                                         image: UIImageService.retrieveImage(for: set.setImgUrl)))
                            setNumArray.append(set.setNum)
                        } else {
                            duplicated = true
                            let page = count / itemsPerPage + 1
                            isRefreshed = true
                            self._cache.save()
                            closure(isRefreshed, page, setCells)
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

    private func computePagination(_ range: Int?, _ itemsPerPage: Int) -> Int {
        guard range != nil else { return 0 }
        return range! / itemsPerPage + (range! % itemsPerPage == 0 ? 0 : 1)
    }

}

enum GarbageErrors: Error {
    case httpBadResult
}
