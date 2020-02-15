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
    private var _api: APIDelegate

    init(viewController: SetPartsTableViewCell, setPart: SetPartCell, api: APIDelegate) {
        _api = api
        _viewController = viewController
        _setPart = setPart
        commonConfig()
    }

    init(viewController: SetPartsTableViewCell, setPart: SetPartCell) {
        _api = API()
        _viewController = viewController
        _setPart = setPart
        commonConfig()
    }

    private func commonConfig() {
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

    private func retrieveCategory() {
        DispatchQueue.main.async {
            self._api.retrieveCategoryFor(setPart: self._setPart) { category in
                self._setPart.category = category
                self.partCategoryUpdated()
            }
        }
    }

    private func retrieveImage() {
        DispatchQueue.main.async {
            self._setPart.image = UIImageService.retrieveImage(for: self._setPart.setPart!.part!.partImgURL)
            self.partImageUpdated()
        }
    }
}
