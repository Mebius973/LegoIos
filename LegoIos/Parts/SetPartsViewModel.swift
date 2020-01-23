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

    func configure(with setCell: SetCell) {
           _setCell = setCell
    }

    func fetchSetParts(_ closure: (() -> Void)?) {
        retrieveParts(closure)
    }

    func getSetPartCelldAt(index: Int) -> SetPartCell {
        return _setParts[index]
    }

    private func retrieveParts(_ closure: (() -> Void)?) {
        if let setNum = _setCell!.set!.setNum {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)\(setNum)/\(Constants.PartsEndPoint)"
            let params = "?\(authorization)"
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
                            let setPartsQueryResult = try jsonDecoder.decode(SetPartsQueryResult.self, from: data)
                            let parts = setPartsQueryResult.results!
                            for part in parts {
                                let partCell = SetPartCell()
                                partCell.setPart = part
                                self._setParts.append(partCell)
                            }
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
}
