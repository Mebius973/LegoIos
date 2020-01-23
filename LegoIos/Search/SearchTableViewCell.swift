//
//  SearchTableViewCell.swift
//  LegoIos
//
//  Created by Mebius on 02/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    var setCell: SetCell? {
        didSet {
            nameLabel.text = setCell!.set!.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with setCell: SetCell) {
        self.setCell = setCell
    }
}
