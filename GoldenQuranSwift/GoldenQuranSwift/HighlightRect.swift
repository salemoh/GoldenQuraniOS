//
//  HighlightRect.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/21/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class HighlightRect: NSObject {

    /*x , y , width , height , 
     upper_left_x ,upper_left_y , upper_right_x, upper_right_y ,
     lower_right_x , lower_right_y, lower_left_x , lower_left_y , 
     ayah , line , surah , page_number*/
    var x:Float?
    var y:Float?
    var width: Float?
    var height:Float?
    
    var upperLeftX:Float?
    var upperLeftY:Float?
    var upperRightX:Float?
    var upperRightY:Float?
    
    var lowerLeftX:Float?
    var lowerLeftY:Float?
    var lowerRightX:Float?
    var lowerRightY:Float?
    
    var line:Int?
    var ayah:Int?
    var sora:Int?
    
    var pageNumber:Int?
    
}
