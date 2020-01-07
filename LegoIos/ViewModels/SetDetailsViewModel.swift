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

    init(viewController: SetDetailsViewController, setCell: SetCell) {
        _viewController = viewController
        _setCell = setCell
        retrieveImage()
        retrieveTheme()
    }

    func getSetCell() -> SetCell {
        return self._setCell
    }

    private func setImageUpdated() {
        _viewController!.setImageUpdated()
    }

    private func setThemeUpdated() {
        _viewController!.setCategoryUpdated()
    }

    private func retrieveImage() {
        DispatchQueue.main.async {
            self._setCell.image = UIImageService.retrieveImage(for: self._setCell.set?.setImgUrl)
            self.setImageUpdated()
        }

    }

    private func retrieveTheme() {
        if let themeId = _setCell.set!.themeId {
            let authorization = "key=\(AppConfig.LegoApiKey)"
            let baseUrl = "\(Constants.ApiBaseURL)\(Constants.ThemesEndPoint)\(themeId)/"
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
                            self._setCell.theme = try jsonDecoder.decode(Theme.self, from: data)
                            self.setThemeUpdated()
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
