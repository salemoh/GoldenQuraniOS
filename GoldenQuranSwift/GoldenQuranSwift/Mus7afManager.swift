//
//  Mus7afManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import Foundation

class Mus7afManager: NSObject {
    
    static let shared:Mus7afManager = Mus7afManager()
    
    fileprivate var _currentMus7af:Mus7af = Mus7af()
    var currentMus7af:Mus7af {
        get{
            if let _ = _currentMus7af.id {
                return _currentMus7af
            }
            
            loadCurrentMushaf()
            
            if let _ = _currentMus7af.id {
                return _currentMus7af
            }
            return _currentMus7af
        }
        set {
            _currentMus7af = newValue
        }
    }
    

    
    var hasMushaf:Bool {
        get{
            if let _ = self.currentMus7af.id {
                return true
            }
            return false
        }
    }
    
    func updateMushafValues( mushaf:Mus7af) {
        mushaf.updatedAt = Date().timeStamp
        DBManager.shared.updateMushaf(mushafObject: mushaf)
    }
    
    func createNewMushaf( mushaf:Mus7af)  {
        
        mushaf.currentPage = mushaf.startOffset! + 1
        mushaf.currentSurah = 1
        mushaf.currentAyah = 1
        
        let randomNum:UInt32 = arc4random_uniform(100000) // range is 0 to 99
        let randomTime:TimeInterval = TimeInterval(randomNum)
        let guidString:String = String(randomTime) //string works too
        
        mushaf.guid = guidString
        mushaf.createdAt = Date().timeStamp
        mushaf.updatedAt = Date().timeStamp
        
        mushaf.recitationId = RecitationManager.getRecitations()[0].id! /// set current recitation id
        
        DBManager.shared.insertNewMushaf(mushafObject: mushaf)
    }
    
    func userMushafs() -> [Mus7af] {
        return DBManager.shared.getUserMus7afs()
    }
    
    func saveCurrentMushaf(){
        if let _ = self.currentMus7af.guid {
            UserDefaults.standard.set(self.currentMus7af.guid, forKey: Constants.CURRENT_MUSHAF_KEY)
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadCurrentMushaf(){
        
        if let currentMushafGUID = UserDefaults.standard.object(forKey: Constants.CURRENT_MUSHAF_KEY)  {
            let mushafList = userMushafs()
            for mushafObject in  mushafList {
                if mushafObject.guid == (currentMushafGUID as! String) {
                    self._currentMus7af = mushafObject
                    self._currentMus7af.tableOfContents = DBManager.shared.getMushafTOC(mushaf: mushafObject)
                    return
                }
            }
        }
        self._currentMus7af = Mus7af()
    }
}
