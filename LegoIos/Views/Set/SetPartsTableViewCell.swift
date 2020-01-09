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
    @IBOutlet weak var partsNum: UILabel!
    @IBOutlet weak var partsImageSpinner: UIActivityIndicatorView!
    @IBOutlet weak var partsCategorySpinner: UIActivityIndicatorView!

    private var _setPart: SetPartCell?
    private var _viewModel: SetPartViewModel?
    private var isInitialized = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSpinners()
    }

    func configure(with setPart: SetPartCell) {
        if !isInitialized {
            self._setPart = setPart
            self._viewModel = SetPartViewModel(viewController: self, setPart: _setPart!)
            updateUIElements()
            self.isInitialized = true
        }
    }

    func partsImageUpdated() {
        DispatchQueue.main.async {
            self.partsImageSpinner.stopAnimating()
            self._setPart = self._viewModel!.getSetPart
            self.partsImage.image = self._setPart!.image
        }
    }

    func partsCategoryUpdated() {
        DispatchQueue.main.async {
            self.partsCategorySpinner.stopAnimating()
            self._setPart = self._viewModel!.getSetPart
            self.partsCategory.text = self._setPart!.category
            self.partsCategory.isHidden = false
        }
    }

    private func addSpinners() {
        partsImageSpinner.hidesWhenStopped = true
        partsImageSpinner.startAnimating()
        partsCategory.isHidden = true
        partsCategorySpinner.hidesWhenStopped = true
        partsCategorySpinner.startAnimating()
    }

    private func updateUIElements() {
        if let setPart = _setPart!.setPart {
            partsName.text = setPart.part!.name
            partsColor.text = setPart.color!.name
            partsQuantity.text = String(setPart.quantity!)
            partsNum.text = setPart.part!.partNum
        }
    }
}
