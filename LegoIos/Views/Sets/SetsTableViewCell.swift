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

    private var _setCell: SetCell?
    var setCell: SetCell? { get {
            return _setCell
        }
        set(newValue) {
            _setCell = newValue
            mainLabel.text = newValue?.set.name
            mainImage.image = newValue?.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with setCell: SetCell) {
        self.setCell = setCell
        buyButton.configure(with: setCell)
        detailButton.configure(with: setCell)
    }
}
