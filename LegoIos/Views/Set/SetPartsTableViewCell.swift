//
//  SetPartsTableViewCell.swift
//  LegoIos
//
//  Created by Mebius on 30/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetPartsTableViewCell: UITableViewCell {
    @IBOutlet weak var partsImage: UIImageView!
    @IBOutlet weak var partsName: UILabel!
    @IBOutlet weak var partsColor: UILabel!
    @IBOutlet weak var partsQuantity: UILabel!
    @IBOutlet weak var partsCategory: UILabel!

    private var _setPart: SetPartPresentable? {
        didSet {
            partsImage.image = _setPart!.image
            partsName.text = _setPart!.name
            partsColor.text = _setPart!.color
            partsQuantity.text = _setPart!.quantity
            partsCategory.text = _setPart!.category
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with setPart: SetPartPresentable) {
        self._setPart = setPart
    }
}
