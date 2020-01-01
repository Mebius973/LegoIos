//
//  SetPartsViewModel.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class SetPartsViewModel {
    var count: Int {
        return _setParts.count
    }

    private var _setCell: SetCell?
    private var _setParts = [SetPartPresentable]()

    func configure(setCell: SetCell) {
        _setCell = setCell
    }

    func fetchSetParts(_ closure: (() -> Void)?) {
        retrieveParts(closure)
    }

    func getSetPartDetailedAt(index: Int) -> SetPartPresentable {
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
                            let setParts = setPartsQueryResult.results!
                            for setPart in setParts {
                                let part = SetPartPresentable(
                                    name: setPart.part!.name!,
                                    color: setPart.color!.name!,
                                    quantity: String(setPart.quantity!),
                                    category: String(setPart.part!.partCatID!),
                                    image: UIImageService.retrieveImage(for: setPart.part!.partImgURL!)!
                                )
                                self._setParts.append(part)
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
