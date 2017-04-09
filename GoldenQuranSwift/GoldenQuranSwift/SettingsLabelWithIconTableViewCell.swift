//
//  SettingsLabelWithIconTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/6/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class SettingsLabelWithIconTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgSepratore: UIImageView!
    @IBOutlet weak var lblTitle: GQLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
