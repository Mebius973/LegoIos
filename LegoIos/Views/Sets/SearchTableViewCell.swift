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

    private var _searchResult: SearchResult? {
        didSet {
            nameLabel.text = _searchResult?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with searchResult: SearchResult) {
        self._searchResult = searchResult
    }
}