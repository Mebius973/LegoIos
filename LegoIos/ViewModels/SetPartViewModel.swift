//
//  SetPartViewModel.swift
//  LegoIos
//
//  Created by Mebius on 07/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation

class SetPartViewModel {

    private weak var _viewController: SetPartsTableViewCell?
    private var _setPart: SetPartCell

    init(viewController: SetPartsTableViewCell, setPart: SetPartCell) {
        _viewController = viewController
        _setPart = setPart
        retrieveImage()
        retrieveCategory()
    }

    var getSetPart: SetPartCell { return _setPart }

    private func partImageUpdated() {
        _viewController!.partsImageUpdated()
    }

    private func partCategoryUpdated() {
        _viewController!.partsCategoryUpdated()
    }

    private func retrieveImage() {
        DispatchQueue.main.async {
            self._setPart.image = UIImageService.retrieveImage(for: self._setPart.setPart!.part!.partImgURL)
            self.partImageUpdated()
        }
    }

    private func retrieveCategory() {
        if let categoryId = _setPart.setPart!.part!.partCatID {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.PartCategoriesEndPoint)\(categoryId)/"
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
                            self._setPart.category = (try jsonDecoder.decode(Theme.self, from: data)).name
                            self.partCategoryUpdated()
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
