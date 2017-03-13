//
//  MushafListTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/6/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMushafIcon:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblType:UILabel!    
    @IBOutlet weak var lblUpdatedAt:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillFromMushaf(mushaf:Mus7af){
        
        let date = Date(timeIntervalSince1970: mushaf.updatedAt!)
        
        self.lblName.text = mushaf.name
        self.lblType.text = NSLocalizedString("\(mushaf.type!)_NOVEL", comment: "")
        self.imgMushafIcon.image = mushaf.logo
        self.lblUpdatedAt.text =  date.toStringWithRelativeTime().correctLanguageNumbers()
    }

}
