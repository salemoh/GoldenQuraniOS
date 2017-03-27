//
//  PrayerSwitchEnableTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/27/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class PrayerSwitchEnableTableViewCell: UITableViewCell {

    var actionsHandler: ((Bool)->Void)?
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var switchEnable:UISwitch!
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if let _ = actionsHandler {
            actionsHandler!(sender.isOn)
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

}
