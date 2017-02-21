//
//  NSAttributedStringExtensions.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/21/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {

    func getAttributedString(originalString:String, stringToAttribute:String , font:UIFont? , isUnderlined:Bool? , color:UIColor?)->(NSMutableAttributedString){
        
        var attributes:[String : Any] = [:]
        
        if let _font = font {
            attributes[NSFontAttributeName] = _font
        }
        
        if let _isUnderlined = isUnderlined, _isUnderlined == true {
            attributes[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
        }
        
        if let _color = color {
            attributes[NSForegroundColorAttributeName] = _color
        }
        
        let textToAttribute =  NSString(format: originalString as NSString)
        let mutableString = NSMutableAttributedString(string:textToAttribute as String)
        
        mutableString.addAttributes(attributes, range: textToAttribute.range(of: stringToAttribute))
        
        return mutableString
    }

}
