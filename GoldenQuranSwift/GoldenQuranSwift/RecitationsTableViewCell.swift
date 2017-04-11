//
//  RecitationsTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/10/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class RecitationsTableViewCell: UITableViewCell {

    var actionsHandler: ((RecitationsTableViewCell)->Void)?
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblRecitationTitle: GQLabel!
    @IBOutlet weak var imgRecitation: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favouritePressed(_ sender: UIButton) {
        if let _ = actionsHandler {
            actionsHandler!(self)
        }
    }

}
