//
//  FontManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/8/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

struct FontManager {
    
    static func fontWithSize( size:CGFloat,isBold:Bool = false) -> UIFont
    {
        if UIApplication.isEn() {
            return enFont(size: size , isBold: isBold)
        } else  {
            return arFont(size: size , isBold: isBold)
        }
    }
    
    static func enFont( size:CGFloat , isBold:Bool = false) -> UIFont
    {
        if let font = UIFont(name:"Helvetica Neue W23 for SKY",size:size), !isBold {
            return font
        }
        
        if let font = UIFont(name: "HelveticaNeueW23forSKY-Bd", size: size), isBold {
            return font
        }
        
        if isBold {
            return UIFont.boldSystemFont(ofSize: size)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    static func arFont( size:CGFloat,isBold:Bool = false) -> UIFont
    {
        if let font = UIFont(name:"Helvetica Neue W23 for SKY",size:size), !isBold {
            return font
        }
        
        if let font = UIFont(name: "HelveticaNeueW23forSKY-Bd", size: size), isBold {
            return font
        }
        
        if isBold {
            return UIFont.boldSystemFont(ofSize: size)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
        
    }
    
    static func preferredFontSize() -> Int{
        let size = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.preferedFontSize)
        if  size > 0 {
            return size
        }
        return 14
    }
    
    static func setPreferredFontSize( size:Int) {
        if size > 16 && size < 30 {
            UserDefaults.standard.set(size, forKey: Constants.userDefaultsKeys.preferedFontSize)
            UserDefaults.standard.synchronize()
        }
        
    }
    
}

