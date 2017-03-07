//
//  Mus7afManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class Mus7afManager: NSObject {
    
    static let shared:Mus7afManager = Mus7afManager()
    
    var currentMus7af:Mus7af = Mus7af()
    
    func createNewMushaf(mushaf:Mus7af)  {
        
        mushaf.currentPage = mushaf.startOffset! + 1
        mushaf.currentSurah = 1
        mushaf.currentAyah = 1
        
        let randomNum:UInt32 = arc4random_uniform(100000) // range is 0 to 99
        let randomTime:TimeInterval = TimeInterval(randomNum)
        let guidString:String = String(randomTime) //string works too
        
        mushaf.guid = guidString
        mushaf.createdAt = Date().timeStamp
        mushaf.updatedAt = Date().timeStamp
        
        DBManager.shared.insertNewMushaf(mushafObject: mushaf)
    }
    
    func userMushafs() -> [Mus7af] {
        return DBManager.shared.getUserMus7afs()
    }
}
