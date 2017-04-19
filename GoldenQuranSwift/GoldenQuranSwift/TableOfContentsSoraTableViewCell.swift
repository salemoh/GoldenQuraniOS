//
//  TableOfContentsSoraTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/19/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class TableOfContentsSoraTableViewCell: UITableViewCell {

    @IBOutlet weak var lblVersesCount: UILabel!
    @IBOutlet weak var lblSoraNo: UILabel!
    @IBOutlet weak var lblSoraLocation: UILabel!
    @IBOutlet weak var lblSoraName: GQLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
