//
//  GQSegmentedControl.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class GQSegmentedControl: UISegmentedControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var isBoldFont = false
    var textFontSize:CGFloat = 12.0
    var textFontColor:UIColor = UIColor.black
    
    @IBInspectable var isBold: Bool {
        get {
            return isBoldFont
        }
        set {
            self.isBoldFont = newValue
            updateToNewFont()
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        get {
            return textFontSize
        }
        set {
            self.textFontSize = newValue
            updateToNewFont()
        }
    }
    
    @IBInspectable var fontColor: UIColor {
        get {
            return textFontColor
        }
        set {
            self.textFontColor = newValue
            updateToNewFont()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateToNewFont()
    }
    
    func updateToNewFont(){
        
        let font = FontManager.fontWithSize(size: self.textFontSize, isBold: self.isBoldFont)
        let attributes = [NSFontAttributeName : font , NSForegroundColorAttributeName : self.textFontColor] as [String : Any]
        self.setTitleTextAttributes(attributes , for: .normal)
        self.setTitleTextAttributes(attributes , for: .highlighted)
        self.setTitleTextAttributes(attributes , for: .selected)

        //        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
    }
    
}
