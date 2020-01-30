//
//  SetViewModel.swift
//  LegoIos
//
//  Created by Mebius on 26/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetDetailsViewModel {
    private var _setCell: SetCell

    private weak var _viewController: SetDetailsViewController?
    private var _api: APIDelegate

    init(viewController: SetDetailsViewController, setCell: SetCell) {
        _viewController = viewController
        _setCell = setCell
        _api = API()
        commonConfig()
    }

    init(viewController: SetDetailsViewController, setCell: SetCell, api: APIDelegate) {
        _viewController = viewController
        _setCell = setCell
        _api = api
        commonConfig()
    }

    var getSetCell: SetCell {
        return self._setCell
    }

    private func commonConfig() {
        retrieveImage()
        retrieveCategory()
    }

    private func setImageUpdated() {
        if _viewController != nil {
            _viewController!.setImageUpdated()
        }
    }

    private func setCategoryUpdated() {
        if _viewController != nil {
            _viewController!.setCategoryUpdated()
        }
    }

    private func retrieveImage() {
        DispatchQueue.main.async {
            self._setCell.image = UIImageService.retrieveImage(for: self._setCell.set?.setImgUrl)
            self.setImageUpdated()
        }
    }

    private func retrieveCategory() {
        DispatchQueue.main.async {
            self._api.retrieveCategory(setCell: self._setCell) { category in
                self._setCell.category = category
                self.setCategoryUpdated()
            }
        }
    }
}
