//
//  UIImageServiceDelegate.swift
//  LegoIos
//
//  Created by Mebius on 17/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

protocol UIImageServiceDelegate: class {
    static func retrieveImage(for urlString: String?) -> UIImage?
}
