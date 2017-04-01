//
//  MushafFeaturesIconLabelTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/29/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafFeaturesIconLabelTableViewCell: UITableViewCell {
    
    var actionsHandler: ((Bool)->Void)?
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgSeprator: UIImageView!
    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if let _ = actionsHandler {
            actionsHandler!(sender.isOn)
        }
    }
}
