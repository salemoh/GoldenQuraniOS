//
//  SearchTopicTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/16/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class SearchTopicTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSearchContent: UILabel!
    @IBOutlet weak var lblToVerse: UILabel!
    @IBOutlet weak var lblFromVerse: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblSora: GQLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
