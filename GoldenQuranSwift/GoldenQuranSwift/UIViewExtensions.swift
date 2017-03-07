//
//  UIViewRoundedCorners.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/21/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

/*
 This Class is handle all UIView extension that should be required by the app
 the initial solution of this extesion found in
 http://stackoverflow.com/questions/25591389/uiview-with-shadow-rounded-corners-and-custom-drawrect
 
 Modified to change shadow color
 */
import UIKit

extension UIView {
    
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var borderWidth: Float {
        get {
            return Float(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let currentShadowColor = self.layer.borderColor {
                return  UIColor(cgColor:currentShadowColor)
            } else {
                return  UIColor.black
            }
        }
        set {
            self.layer.borderColor = newValue.cgColor
            
            
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // the masksToBound property if a shadow is needed in addition to the cornerRadius
            if self.layer.shadowOpacity > 0.0 {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            if let currentShadowColor = self.layer.shadowColor {
                return  UIColor(cgColor:currentShadowColor)
            } else {
                return  UIColor.black
            }
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            
            
        }
    }
    
}
