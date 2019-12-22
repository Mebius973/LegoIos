//
//  LegoTableViewCell.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewCell: UITableViewCell, UISetCellDelegate {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!

    private var _setCell: SetCell? {
        didSet {
            mainLabel.text = _setCell!.set.name
            mainImage.image = _setCell!.image
        }
    }

    var setCell: SetCell? {
        return _setCell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with setCell: SetCell) {
        self._setCell = setCell
    }
}
