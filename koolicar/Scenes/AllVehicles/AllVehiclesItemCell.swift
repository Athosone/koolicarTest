//
//  AllVehiclesItemCell.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import UIKit
import SDWebImage

class AllVehiclesItemCell: UITableViewCell {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var categoryWrapperView: UIView!

    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var vehicleBrandLabel: UILabel!
    @IBOutlet weak var vehicleDescLabel: UILabel!
    @IBOutlet weak var vehicleInfosLabel: UILabel!
    @IBOutlet weak var vehicleCategoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.wrapperView.backgroundColor = Theme.Color.primaryColor.color

        self.categoryWrapperView.backgroundColor = Theme.Color.backgroundColor.color
        self.categoryWrapperView.clipsToBounds = true
        self.categoryWrapperView.layer.cornerRadius = 9.0

        Theme.set(textThemeColor: .darkPrimaryColor, for: [vehicleBrandLabel])
        Theme.set(textThemeColor: .disabledColor, for: [vehicleInfosLabel, vehicleCategoryLabel, vehicleDescLabel])

        Theme.set(themeFont: .title, for: [vehicleBrandLabel])
        Theme.set(themeFont: .subTitle, for: [vehicleInfosLabel, vehicleCategoryLabel, vehicleDescLabel])

        self.vehicleImageView.contentMode = .scaleToFill
    }

    func fillWithItem(item: VehicleItem) {
        self.vehicleBrandLabel.text = item.brand
        self.vehicleInfosLabel.text = item.infosLabel
        self.vehicleDescLabel.text = item.descLabel
        self.vehicleCategoryLabel.text = item.category.capitalized
        self.vehicleImageView.sd_setImage(with: item.vehicleImage, completed: nil)
    }

}
