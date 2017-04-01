//
//  MushafTopic.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/30/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

struct MushafTopic {
    var soraNo:Int?
    var fromAyah:Int?
    var toAyah:Int?
    var description:String?
    var colorIndex:Int?
    var color:UIColor?{ get{
        if let _colorIndex = colorIndex {
            switch _colorIndex {
            case 1:
                return UIColor.red.withAlphaComponent(0.3)
            case 2:
                return UIColor.green.withAlphaComponent(0.3)
            case 3:
                return UIColor.yellow.withAlphaComponent(0.3)
            case 4:
                return UIColor.brown.withAlphaComponent(0.3)
            case 5:
                return UIColor.purple.withAlphaComponent(0.3)
            case 6:
                return UIColor.cyan.withAlphaComponent(0.3)
            case 7:
                return UIColor.orange.withAlphaComponent(0.3)
            default:
                return UIColor.black.withAlphaComponent(0.3)
            }
        }
        return nil
        }
    }
    
}
