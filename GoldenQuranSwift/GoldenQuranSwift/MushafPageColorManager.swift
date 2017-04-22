//
//  MushafPageColorManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/5/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import Foundation
import UIKit


enum MushafPageColor:String {
    case red    = "MushafPageColorRed"
    case green  = "MushafPageColorGreen"
    case blue   = "MushafPageColorBlue"
    case white  = "MushafPageColorWhite"
    case yellow = "MushafPageColorYellow"
    case night  = "MushafPageColorNight"
    
    
    
}

struct MushafPageColorManager {
    static var currentColor:MushafPageColor{
        get{
            if let color = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor) as? String {
                switch color {
                case MushafPageColor.red.rawValue:
                    return MushafPageColor(rawValue:MushafPageColor.red.rawValue)!
                    
                case MushafPageColor.green.rawValue:
                    return MushafPageColor(rawValue:MushafPageColor.green.rawValue)!
                    
                case MushafPageColor.blue.rawValue:
                    return MushafPageColor(rawValue:MushafPageColor.blue.rawValue)!
                    
                case MushafPageColor.white.rawValue:
                    return MushafPageColor(rawValue:MushafPageColor.white.rawValue)!
                    
                case MushafPageColor.night.rawValue:
                    return MushafPageColor(rawValue:MushafPageColor.night.rawValue)!
                    
                default:
                    return MushafPageColor(rawValue:MushafPageColor.yellow.rawValue)!
                }
            } else {
                return MushafPageColor(rawValue:MushafPageColor.yellow.rawValue)!
            }
        }
    }
    var backgroundColor:UIColor{
        get{
            if let color = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor) as? String {
                switch color {
                case MushafPageColor.red.rawValue:
                    return UIColor.red
                    
                case MushafPageColor.green.rawValue:
                    return UIColor.green
                    
                case MushafPageColor.blue.rawValue:
                    return UIColor.blue
                    
                case MushafPageColor.white.rawValue:
                    return UIColor.white
                    
                case MushafPageColor.night.rawValue:
                    return UIColor.black
                    
                default:
                    return UIColor.yellow
                }
            } else {
                return UIColor.yellow
            }
        }
    }
    
    func getBackgroundImage( isLeft:Bool) -> UIImage? {
        if let color = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor) as? String {
            switch color {
            case MushafPageColor.red.rawValue:
                if isLeft {
                    return UIImage(named:"pageLeftRed")!
                }
                return UIImage(named:"pageRightRed")!
                
            case MushafPageColor.green.rawValue:
                if isLeft {
                    return UIImage(named:"pageLeftGreen")!
                }
                return UIImage(named:"pageRightGreen")!
                
            case MushafPageColor.blue.rawValue:
                if isLeft {
                    return UIImage(named:"pageLeftBlue")!
                }
                return UIImage(named:"pageRightBlue")!
                
            case MushafPageColor.white.rawValue:
                if isLeft {
                    return UIImage(named:"pageLeftWhite")!
                }
                return UIImage(named:"pageRightWhite")!
                
            case MushafPageColor.night.rawValue:
                return nil
                
            default:
                if isLeft {
                    return UIImage(named:"pageLeftYellow")!
                }
                return UIImage(named:"pageRightYellow")!
            }
        } else {
            if isLeft {
                return UIImage(named:"pageLeftYellow")!
            }
            return UIImage(named:"pageRightYellow")!
        }
    }
}

