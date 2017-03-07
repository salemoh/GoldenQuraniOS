//
//  StringExtensions.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/23/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func toEnglishNumbers() -> String {
        var numberString: String = self
        
        let numbersDictionary:NSDictionary = ["1":"١", "2" : "٢", "3" : "٣", "4" : "٤", "5" : "٥", "6" : "٦", "7" : "٧", "8" : "٨", "9" : "٩" , "0":"٠"]
        
        for key in numbersDictionary.allKeys {
            numberString = numberString.replacingOccurrences(of: numbersDictionary[key] as! String, with:key  as! String)
        }
        
        return numberString
    }
    
    func toArabicNumbers() -> String {
        var numberString: String = self
        
        let numbersDictionary:NSDictionary = ["١":"1", "٢":"2" , "٣":"3" ,  "٤":"4" , "٥":"5" , "٦" : "6", "٧" : "7" ,  "٨" : "8" , "٩":"9" , "٠":"0"]
        
        for key in numbersDictionary.allKeys {
            numberString = numberString.replacingOccurrences(of: numbersDictionary[key] as! String, with:key  as! String)
        }
        
        return numberString
    }
}
