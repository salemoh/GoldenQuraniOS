//
//  PrayerTimeTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/27/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class PrayerTimeTableViewCell: UITableViewCell {

    var actionsHandler: ((Bool)->Void)?
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var imgIcon:UIImageView!
    @IBOutlet weak var btnToggleEnable:UIButton!
    
    
    @IBAction func toggleEnabledPressed(_ sender: UIButton) {
        self.btnToggleEnable.isSelected = !btnToggleEnable.isSelected
        if let _ = actionsHandler {
            actionsHandler!(sender.isSelected)
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
