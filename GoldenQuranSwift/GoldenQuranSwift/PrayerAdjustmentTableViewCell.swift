//
//  PrayerAdjustmentTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/27/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class PrayerAdjustmentTableViewCell: UITableViewCell {

    var actionsHandler: ((Void)->Void)?
    
    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var lblTime: GQLabel!
    @IBOutlet weak var lblAdjustment: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    var modificationKey:String?
    
    @IBAction func plusPressed(_ sender: UIButton) {
        var currentAdjustment = UserDefaults.standard.integer(forKey: modificationKey!)
        currentAdjustment += 1
        UserDefaults.standard.set(currentAdjustment, forKey: modificationKey!)
        UserDefaults.standard.synchronize()
        if let _ = actionsHandler {
            actionsHandler!()
        }
        
    }
    @IBAction func minusPressed(_ sender: UIButton) {
        var currentAdjustment = UserDefaults.standard.integer(forKey: modificationKey!)
        currentAdjustment -= 1
        UserDefaults.standard.set(currentAdjustment, forKey: modificationKey!)
        UserDefaults.standard.synchronize()
        if let _ = actionsHandler {
            actionsHandler!()
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
