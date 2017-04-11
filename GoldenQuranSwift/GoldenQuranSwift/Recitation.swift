//
//  Recitation.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/10/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class Recitation: NSObject {

    //"id" INTEGER, "reader" TEXT, "type" TEXT, "baseUrl" TEXT, "name" TEXT)
    var id:Int?
    var reader:String?
    var type:MushafType?
    var baseUrl:String?
    var name:String?
    var image:UIImage{
        get{
            if let _ = self.id {
                return UIImage(named:String(format:"recitation%d", self.id!))!
            }
            return UIImage()
        }
    }
    
}
