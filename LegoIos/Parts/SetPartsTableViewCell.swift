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

    private var partsImageSpinner = UIActivityIndicatorView()
    private var partsCategorySpinner = UIActivityIndicatorView()
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
            if self._setPart!.image != nil {
                self.partsImage.image = self._setPart!.image
            }
            self.partsImage.isHidden = false
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
        partsImageSpinner.backgroundColor = .white
        partsImageSpinner.style = .large
        partsImage.addSubview(partsImageSpinner)
        partsImageSpinner.center = partsImage.center
        partsImageSpinner.startAnimating()
        self.partsCategory.isHidden = true
        partsCategorySpinner.hidesWhenStopped = true
        partsCategorySpinner.backgroundColor = .white
        partsCategory.addSubview(partsCategorySpinner)
        partsCategorySpinner.center.x = partsCategory.bounds.minX + 10
        partsCategorySpinner.center.y = partsCategory.center.y
        partsCategorySpinner.accessibilityLabel = "partsCategorySpinner"
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
