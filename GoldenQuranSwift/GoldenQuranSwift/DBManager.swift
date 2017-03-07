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
    
    static var shared = DBManager(shouldCreateUserDB: true)
    
    var dbQueue:DatabaseQueue?
    
    var dbQueueLibrary:DatabaseQueue?
    
    
    required init(shouldCreateUserDB:Bool) {
        super.init()
        
        do {
            dbQueue = try DatabaseQueue(path: Constants.db.defaultMus7afListDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        do {
            dbQueueLibrary = try DatabaseQueue(path: Constants.db.userMus7afListDBPath)
        } catch {
            print("could not create/ open dbQueueLibrary \(error.localizedDescription)")
        }
        if shouldCreateUserDB == true {
            createUserMushafDB()
        }
    }
    
    //MARK: Functions
    func getDefaultMus7afs()->[Mus7af]? {
        
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
            
            print("could not fetch getDefaultMus7afs \(error.localizedDescription)")
            return nil
        }
        return mus7afList
    }
    
    func insertNewMushaf(mushafObject:Mus7af){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "INSERT INTO Mushaf (id, guid, numberOfPages, type, baseDownloadURL, name, startOffset, dbName , createdAt , updatedAt) " +
                    "VALUES (?, ?, ?, ? , ? , ? , ? , ? , ? , ?)",
                    arguments: [mushafObject.id,
                                mushafObject.guid,
                                mushafObject.numberOfPages,
                                mushafObject.type?.rawValue ,
                                mushafObject.baseImagesDownloadUrl ,
                                mushafObject.name ,
                                mushafObject.startOffset ,
                                mushafObject.dbName,
                                mushafObject.createdAt,
                                mushafObject.updatedAt])
                
            }
        } catch  {
            print("Failed to insert new Mushaf \(error.localizedDescription)")
        }

    }
    
    func createUserMushafDB(){
        do {
            try dbQueueLibrary?.inDatabase { db in
                
                try db.create(table: "Mushaf") { t in
                    
                    t.column("id", .integer)
                    t.column("guid", .text)
                    t.column("numberOfPages", .integer)
                    t.column("type", .text)
                    t.column("baseDownloadURL", .text)
                    t.column("name", .text)
                    t.column("startOffset", .integer)
                    t.column("dbName", .text)
                    t.column("createdAt", .double)
                    t.column("updatedAt", .double)
                    
                }
            }
        } catch  {
            print("Failed to create UserMushafDB \(error.localizedDescription)")
        }
    
    }
    
    func getUserMus7afs()->[Mus7af] {
        
        var mus7afList:[Mus7af] = []
        do {
            try dbQueueLibrary?.inDatabase { db in
                let rows = try Row.fetchCursor(db, "SELECT id, numberOfPages,type,baseDownloadURL,name,startOffset, dbName createdAt, updatedAt FROM Mushaf order by updatedAt DESC")
                
                while let row = try rows.next() {
                    let mus7afItem = Mus7af()
                    mus7afItem.id = row.value(named: "id")
                    mus7afItem.numberOfPages = row.value(named: "numberOfPages")
                    mus7afItem.type = MushafType(rawValue: row.value(named: "type"))
                    mus7afItem.baseImagesDownloadUrl = row.value(named: "baseDownloadURL")
                    mus7afItem.name = row.value(named: "name")
                    mus7afItem.startOffset = row.value(named: "startOffset")
                    mus7afItem.dbName = row.value(named: "dbName")
                    mus7afItem.createdAt = row.value(named: "createdAt")
                    mus7afItem.updatedAt = row.value(named: "updatedAt")
                    
                    mus7afList.append(mus7afItem)
                }
            }
            
        } catch  {
            print("could not fetch getUserMus7afs \(error.localizedDescription)")
        }
        return mus7afList
    }
    

}
