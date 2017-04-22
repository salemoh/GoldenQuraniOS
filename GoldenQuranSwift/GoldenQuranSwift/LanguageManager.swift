//
//  LanguageManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/7/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import Foundation
import UIKit

enum LanguageType:String {
    case ar = "ar"
    case en = "en"
}

struct LanguageManager {
    
    static func deviceLanguage() -> String {
        
        let languages = UserDefaults.standard.object(forKey: Constants.iOS_LANGUAGES_KEY) as! NSArray
        return languages.firstObject as! String
    }
    
    static func changeLanguageTo( lang: LanguageType) {
        
        UserDefaults.standard.set([lang.rawValue,deviceLanguage()], forKey: Constants.iOS_LANGUAGES_KEY)
        UserDefaults.standard.synchronize()
        
        if lang == .ar {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        LocalizerHelper.DoTheSwizzling()
    }
    
} 




extension UIApplication {
    
    func isAr() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    func isEn() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection != .rightToLeft
    }
    
    var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if LanguageManager.deviceLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
    
}

/*
 These methods to replace the original functions for localization 
 It will fix the locations strings, UILable text alignment direction
 
 https://github.com/MoathOthman/Localization102/tree/swift3
 https://medium.com/@dark_torch/working-with-localization-in-swift-4a87f0d393a4#.bxwjrxawt
 */

extension UILabel {
    public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        
        if self.textAlignment == .center {
            return
        }
        
        if self.tag <= 0  {
            if UIApplication.isAr()  {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        
        if self.tag <= 0 {
            if UIApplication.isAr()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}

extension Bundle {
    func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LanguageManager.deviceLanguage()
        var bundle = Bundle()
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        
        return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }
}

/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector);
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector);
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

class LocalizerHelper: NSObject {
    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
        
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
}

