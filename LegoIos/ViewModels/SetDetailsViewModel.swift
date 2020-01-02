//
//  SetViewModel.swift
//  LegoIos
//
//  Created by Mebius on 26/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetDetailsViewModel {
    private var _setDetails = SetDetails()
    private var _setNum: String

    private weak var _viewController: SetDetailsViewController?

    init(viewController: SetDetailsViewController, setNum: String) {
        _viewController = viewController
        _setNum = setNum
        retrieveSet {
            self.retrieveTheme()
        }
    }

    private func setDetailsUpdated() {
        _viewController?.setDetailsUpdated(setDetails: _setDetails)
    }

    private func retrieveSet(_ closure: (() -> Void)? = nil) {
        let authorization = "key=\(AppConfig.LegoApiKey)"
        let baseUrl = "\(Constants.ApiBaseURL)\(Constants.SetsEndPoint)\(_setNum)/"
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
                        let set = try jsonDecoder.decode(Set.self, from: data)
                        let image = UIImageService.retrieveImage(for: set.setImgUrl)
                        self._setDetails.setCell = SetCell(set: set, image: image)
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

    private func retrieveTheme() {
        if let themeId = _setDetails.setCell!.set!.themeId {
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
                            self._setDetails.theme = try jsonDecoder.decode(Theme.self, from: data)
                            self.setDetailsUpdated()
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
