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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
