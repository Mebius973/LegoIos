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
    @IBAction func buyButton(_ sender: UIButton) {
    }
    @IBAction func detailsButton(_ sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
