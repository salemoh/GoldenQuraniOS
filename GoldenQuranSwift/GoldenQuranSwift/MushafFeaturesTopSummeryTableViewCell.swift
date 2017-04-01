//
//  MushafFeaturesTopSummeryTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/29/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafFeaturesTopSummeryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblHijriDate: GQLabel!
    @IBOutlet weak var btnEditHijri: GQButton!
    @IBOutlet weak var lblNextPrayTime: GQButton!
    @IBOutlet weak var lblDate: GQLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
