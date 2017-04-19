//
//  BookmarksTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/13/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var lblSubtitle: GQLabel!
    @IBOutlet weak var lblLastUse: GQLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
