//
//  SettingsFontSizeTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/5/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class SettingsFontSizeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblPreview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        refreshLabelSize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        var size = FontManager.preferredFontSize()
        size -= 3
        FontManager.setPreferredFontSize(size: size)
        refreshLabelSize()
    }

    @IBAction func plusPressed(_ sender: Any) {
        var size = FontManager.preferredFontSize()
        size += 3
        FontManager.setPreferredFontSize(size: size)
        refreshLabelSize()
    }
    
    func refreshLabelSize(){
        let size = FontManager.preferredFontSize()
        lblPreview.font = lblPreview.font.withSize(CGFloat(size))
    }
}
