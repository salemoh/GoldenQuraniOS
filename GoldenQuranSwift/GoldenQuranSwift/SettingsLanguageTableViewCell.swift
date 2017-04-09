//
//  SettingsLanguageTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/6/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class SettingsLanguageTableViewCell: UITableViewCell {

    var actionsHandler: ((Int)->Void)?
    
    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var segmentLanguage: GQSegmentedControl!
    @IBOutlet weak var imgSepratore: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIApplication.isAr() {
            segmentLanguage.selectedSegmentIndex = 1
        }
    }

    @IBAction func segmentValueChanged(_ sender: Any) {
        if let _ = actionsHandler {
            actionsHandler!(segmentLanguage.selectedSegmentIndex)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
