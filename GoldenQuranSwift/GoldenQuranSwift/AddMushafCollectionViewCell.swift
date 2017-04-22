//
//  AddMus7afCollectionViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/21/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class AddMus7afCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNumberOfPages: UILabel!
    @IBOutlet weak var imgMushafIcon: UIImageView!
    @IBOutlet weak var lblMushafName: UILabel!
    @IBOutlet weak var lblMushafType: UILabel!
    
    func fillFromMushaf( mushaf:Mus7af){
        
        self.lblMushafName.text = mushaf.name
        self.lblMushafType.text = NSLocalizedString("\((mushaf.type!))_NOVEL", comment: "")
        
        let pagesCount = "\((mushaf.numberOfPages!))"
        let numberOfPages = NSLocalizedString("NUMBER_OF_PAGES", comment: "") + ": " + pagesCount
        let pagesAttributedText = NSMutableAttributedString().getAttributedString(originalString: numberOfPages.correctLanguageNumbers(), stringToAttribute: pagesCount.correctLanguageNumbers() , font: self.lblNumberOfPages.font, isUnderlined: false, color: UIColor.darkGray , fontSizeDelta: 2)
        self.lblNumberOfPages.attributedText = pagesAttributedText
        self.imgMushafIcon.image = mushaf.logo
    }
}
