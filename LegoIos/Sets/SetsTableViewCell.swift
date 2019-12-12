//
//  LegoTableViewCell.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import UIKit

class SetsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var buyButton: SetsButton!
    @IBOutlet weak var detailButton: SetsButton!

    private var _setNum: String?
    var setNum: String? {
        get {
            return _setNum
        }
        set(newValue) {
            buyButton.setNum = newValue
            detailButton.setNum = newValue
            _setNum = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buyButton.setNum = setNum
        detailButton.setNum = setNum
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
