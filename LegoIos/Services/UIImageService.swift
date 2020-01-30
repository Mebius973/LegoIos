//
//  UIImageService.swift
//  LegoIos
//
//  Created by Mebius on 17/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class UIImageService: UIImageServiceDelegate {
    static func retrieveImage(for optionalUrlString: String?) -> UIImage? {
        var image: UIImage?
        if let urlString = optionalUrlString {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)?
                        .resizeWithScaleAspectFitMode(to: 200)
                }
            }
        } else {
            image = UIImage(named: "no_image_available")?
                .resizeWithScaleAspectFitMode(to: 200)
        }
        return image
    }
}
