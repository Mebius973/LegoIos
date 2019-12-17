//
//  UIImageService.swift
//  LegoIos
//
//  Created by Mebius on 17/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class UIImageService: UIImageServiceDelegate {
    func retrieveImages(viewModel: SetsViewModelDelegate, _ closure: ((_ images: [UIImage?]) -> Void)?) {
        DispatchQueue.main.async {
            let count = viewModel.count
            var images = [UIImage?]()
            for counter in 0...(count - 1) {
                if let urlString = viewModel.urlFor(row: counter) {
                    if let url = URL(string: urlString) {
                        if let data = try? Data(contentsOf: url) {
                            images.append(UIImage(data: data)?
                                .resizeWithScaleAspectFitMode(to: 200, resizeFramework: .uikit))
                        }
                    }
                }
            }
            if closure != nil { closure!(images) }
        }
    }
}
