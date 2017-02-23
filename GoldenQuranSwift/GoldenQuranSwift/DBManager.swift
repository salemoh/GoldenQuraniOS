//
//  DBManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import GRDB


class DBManager: NSObject {
    
    static var shared = DBManager()
    
    var dbQueue:DatabaseQueue?
    
    
    //MARK: Functions
    func getDefaultMus7afs()->[Mus7af]? {
        
        do {
            dbQueue = try DatabaseQueue(path: Constants.db.defaultMus7afListDBPath)
        } catch {
            print("could not create/ open DB")
            return nil
        }
        
        var mus7afList:[Mus7af] = []
        do {
            try dbQueue?.inDatabase { db in
                let rows = try Row.fetchCursor(db, "SELECT id, numberOfPages,type,baseDownloadURL,name,startOffset, dbName FROM Mus7af")
                
                while let row = try rows.next() {
                    let mus7afItem = Mus7af()
                    mus7afItem.id = row.value(named: "id")
                    mus7afItem.numberOfPages = row.value(named: "numberOfPages")
                    mus7afItem.type = MushafType(rawValue: row.value(named: "type"))
                    mus7afItem.baseImagesDownloadUrl = row.value(named: "baseDownloadURL")
                    mus7afItem.name = row.value(named: "name")
                    mus7afItem.startOffset = row.value(named: "startOffset")
                    mus7afItem.dbName = row.value(named: "dbName")
                    
                    mus7afList.append(mus7afItem)
                }
            }
            
        } catch  {
            print("could not fetch  DB")
            return nil
        }
        
        
        
        return mus7afList
    }

}
