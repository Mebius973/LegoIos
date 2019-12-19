//
//  SetsButton.swift
//  LegoIos
//
//  Created by Mebius on 12/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsButton: UIButton {
    var setCell: SetCell?

    func configure(with setCell: SetCell) {
        self.setCell = setCell
    }
}
