//
//  ManageNotificationsTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/9/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class ManageNotificationsTableViewCell: UITableViewCell {

    var actionsHandler: ((Bool)->Void)?
    
    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var lblSubTitle: GQLabel!
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
