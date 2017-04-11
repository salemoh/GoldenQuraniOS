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
                let rows = try Row.fetchCursor(db, "SELECT id, numberOfPages,type,baseDownloadURL,name,startOffset, dbName, imagesNameFormat FROM Mus7af")
                
                while let row = try rows.next() {
                    let mus7afItem = Mus7af()
                    mus7afItem.id = row.value(named: "id")
                    mus7afItem.numberOfPages = row.value(named: "numberOfPages")
                    mus7afItem.type = MushafType(rawValue: row.value(named: "type"))
                    mus7afItem.baseImagesDownloadUrl = row.value(named: "baseDownloadURL")
                    mus7afItem.name = row.value(named: "name")
                    mus7afItem.startOffset = row.value(named: "startOffset")
                    mus7afItem.dbName = row.value(named: "dbName")
                    mus7afItem.imagesNameFormat = row.value(named:"imagesNameFormat")
                    
                    mus7afList.append(mus7afItem)
                }
            }
            
        } catch  {
            
            print("could not fetch getDefaultMus7afs \(error.localizedDescription)")
            return nil
        }
        return mus7afList
    }
    
    func updateMushaf(mushafObject:Mus7af){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "UPDATE Mushaf SET id = ?, guid = ?, numberOfPages = ?, type = ?, baseDownloadURL = ?, name = ?, startOffset = ?, dbName  = ?, imagesNameFormat  = ?, recitationId = ?, createdAt  = ?, updatedAt  = ? WHERE guid = ? " ,
                    arguments: [mushafObject.id,
                                mushafObject.guid,
                                mushafObject.numberOfPages,
                                mushafObject.type?.rawValue ,
                                mushafObject.baseImagesDownloadUrl ,
                                mushafObject.name ,
                                mushafObject.startOffset ,
                                mushafObject.dbName,
                                mushafObject.imagesNameFormat,
                                mushafObject.recitationId,
                                mushafObject.createdAt,
                                mushafObject.updatedAt,
                                mushafObject.guid])
                
            }
        } catch  {
            print("Failed to insert new Mushaf \(error.localizedDescription)")
        }
        
    }
    
    func insertNewMushaf(mushafObject:Mus7af){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "INSERT INTO Mushaf (id, guid, numberOfPages, type, baseDownloadURL, name, startOffset, dbName , imagesNameFormat , recitationId, createdAt , updatedAt ) " +
                    "VALUES (?, ?, ?, ? , ? , ? , ? , ? , ? , ? ,? , ?)",
                    arguments: [mushafObject.id,
                                mushafObject.guid,
                                mushafObject.numberOfPages,
                                mushafObject.type?.rawValue ,
                                mushafObject.baseImagesDownloadUrl ,
                                mushafObject.name ,
                                mushafObject.startOffset ,
                                mushafObject.dbName,
                                mushafObject.imagesNameFormat,
                                mushafObject.recitationId,
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
                try db.create(table: "Mushaf", temporary: false, ifNotExists: true, body: { (t) in
                    t.column("id", .integer)
                    t.column("guid", .text)
                    t.column("numberOfPages", .integer)
                    t.column("type", .text)
                    t.column("baseDownloadURL", .text)
                    t.column("name", .text)
                    t.column("startOffset", .integer)
                    t.column("dbName", .text)
                    t.column("imagesNameFormat", .text)
                    t.column("createdAt", .double)
                    t.column("updatedAt", .double)
                    t.column("recitationId", .integer)
                })
                
//                try db.create(table: "Mushaf") { t in
//                    
//                    t.column("id", .integer)
//                    t.column("guid", .text)
//                    t.column("numberOfPages", .integer)
//                    t.column("type", .text)
//                    t.column("baseDownloadURL", .text)
//                    t.column("name", .text)
//                    t.column("startOffset", .integer)
//                    t.column("dbName", .text)
//                    t.column("createdAt", .double)
//                    t.column("updatedAt", .double)
//                    
//                }
            }
        } catch  {
            print("Failed to create UserMushafDB \(error.localizedDescription)")
        }
    
    }
    
    func getUserMus7afs()->[Mus7af] {
        
        var mus7afList:[Mus7af] = []
        do {
            try dbQueueLibrary?.inDatabase { db in
                let rows = try Row.fetchCursor(db, "SELECT id, guid, numberOfPages,type,baseDownloadURL,name,startOffset, dbName, imagesNameFormat , recitationId , createdAt, updatedAt  FROM Mushaf order by updatedAt DESC")
                
                while let row = try rows.next() {
                    let mus7afItem = Mus7af()
                    mus7afItem.id = row.value(named: "id")
                    mus7afItem.guid = row.value(named: "guid")
                    mus7afItem.numberOfPages = row.value(named: "numberOfPages")
                    mus7afItem.type = MushafType(rawValue: row.value(named: "type"))
                    mus7afItem.baseImagesDownloadUrl = row.value(named: "baseDownloadURL")
                    mus7afItem.name = row.value(named: "name")
                    mus7afItem.startOffset = row.value(named: "startOffset")
                    mus7afItem.dbName = row.value(named: "dbName")
                    mus7afItem.createdAt = row.value(named: "createdAt")
                    mus7afItem.updatedAt = row.value(named: "updatedAt")
                    mus7afItem.imagesNameFormat = row.value(named:"imagesNameFormat")
                    mus7afItem.recitationId = row.value(named:"recitationId")
                    
                    
                    mus7afList.append(mus7afItem)
                }
            }
            
        } catch  {
            print("could not fetch getUserMus7afs \(error.localizedDescription)")
        }
        return mus7afList
    }
    

    func getMus7afHighlightRects(forPage:Int , fromMushafDB:String)->[HighlightRect] {
        
        
         var dbMushafQueue:DatabaseQueue?
         
        
         do {
            dbMushafQueue = try DatabaseQueue(path: Constants.db.mushafWithDBName(name: fromMushafDB))
         } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
         }
        
        
        var highlightRects:[HighlightRect] = []
        do {
            
            try dbMushafQueue?.inDatabase { db in
                
                let query = "SELECT x , y , width , height , upper_left_x , upper_left_y , upper_right_x, upper_right_y , lower_right_x , lower_right_y, lower_left_x , lower_left_y , ayah , line , surah , page_number FROM page  WHERE page_number = " + String(forPage) + " group by surah ,  ayah , line"
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let highlightRect = HighlightRect()
                    highlightRect.x = row.value(named:"x")
                    highlightRect.y = row.value(named:"y")
                    highlightRect.width = row.value(named:"width")
                    highlightRect.height = row.value(named:"height")
                    highlightRect.upperLeftX = row.value(named:"upper_left_x")
                    highlightRect.upperLeftY = row.value(named:"upper_left_y")
                    highlightRect.upperRightX = row.value(named:"upper_right_x")
                    highlightRect.upperRightY = row.value(named:"upper_right_y")
                    highlightRect.lowerRightX = row.value(named:"lower_right_x")
                    highlightRect.lowerRightY = row.value(named:"lower_right_y")
                    highlightRect.lowerLeftX = row.value(named:"lower_left_x")
                    highlightRect.lowerLeftY = row.value(named:"lower_left_y")
                    highlightRect.ayah = row.value(named:"ayah")
                    highlightRect.line = row.value(named:"line")
                    highlightRect.sora = row.value(named:"surah")
                    highlightRect.pageNumber = row.value(named:"page_number")
                    
                    
                    highlightRects.append(highlightRect)
                }
            }
            
        } catch  {
            print("could not fetch getUserMus7afs \(error.localizedDescription)")
        }
        return highlightRects
    }
    

    
    func getMushafByTopic(formAyah:Int , toAyah:Int, soraNo: Int)->[MushafTopic] {
        
        
        var dbMushafByTopicQueue:DatabaseQueue?
        
        
        do {
            dbMushafByTopicQueue = try DatabaseQueue(path: Constants.db.mushafByTopicDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var topics:[MushafTopic] = []
        do {
            
            try dbMushafByTopicQueue?.inDatabase { db in
                
                let query = "SELECT SoraNo,FromAyah,ToAyah,Description ,ColorIndex  FROM data where FromAyah >= " + String(formAyah) + "  AND ToAyah <= " + String(toAyah) + "   AND SoraNo = " + String(soraNo) + "  OR FromAyah <= " + String(formAyah) + "  AND ToAyah >= " + String(formAyah) + "   AND SoraNo = " + String(soraNo) + "  OR FromAyah <= " + String(toAyah) + "  AND ToAyah >= " + String(toAyah) + "   AND SoraNo = " + String(soraNo) + "  group by SoraNo , FromAyah , ToAyah"
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    var topic = MushafTopic()
                    topic.soraNo = row.value(named:"SoraNo")
                    topic.fromAyah = row.value(named:"FromAyah")
                    topic.toAyah = row.value(named:"ToAyah")
                    topic.description = row.value(named:"Description")
                    topic.colorIndex = row.value(named:"ColorIndex")
                    
                    
                    topics.append(topic)
                }
            }
            
        } catch  {
            print("could not fetch getMushafByTopic \(error.localizedDescription)")
        }
        return topics
    }
    
    
    func getMushafRecitations(mushafType:MushafType) -> [Recitation] {
        
        var dbRecitationQueue:DatabaseQueue?
        
        do {
            dbRecitationQueue = try DatabaseQueue(path: Constants.db.mushafRecitationAndTafseerDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        var recitationsList:[Recitation] = []
        do {
            try dbRecitationQueue?.inDatabase { db in
                //"id" INTEGER, "reader" TEXT, "type" TEXT, "baseUrl" TEXT, "name" TEXT
                let query = String(format:"SELECT id,reader,type,baseUrl,name FROM recitation WHERE type = '%@' ORDER BY reader ",mushafType.rawValue)
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let recitationItem = Recitation()
                    recitationItem.id = row.value(named: "id")
                    recitationItem.reader = row.value(named: "reader")
                    recitationItem.type = MushafType(rawValue: row.value(named: "type"))
                    recitationItem.baseUrl = row.value(named: "baseUrl")
                    recitationItem.name = row.value(named: "name")
                    
                    recitationsList.append(recitationItem)
                }
            }
            
        } catch  {
            print("could not fetch getMushafRecitations \(error.localizedDescription)")
        }
        return recitationsList
    }
    
    func getMushafTafseers() -> [Tafseer] {
        
        var dbTafseerQueue:DatabaseQueue?
        
        do {
            dbTafseerQueue = try DatabaseQueue(path: Constants.db.mushafRecitationAndTafseerDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        var tafseersList:[Tafseer] = []
        do {
            try dbTafseerQueue?.inDatabase { db in
                //// ("ID" INTEGER,"MadhabId" INTEGER,"TafsirName" TEXT,"DateOfDeath" TEXT,"AuthName" TEXT)
                let query = String(format:"SELECT ID,MadhabId,TafsirName,DateOfDeath,AuthName FROM quranTfseer ORDER BY TafsirName")
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let tafseerItem = Tafseer()
                    tafseerItem.id = row.value(named: "ID")
                    tafseerItem.madhabId = row.value(named: "MadhabId")
                    tafseerItem.name = row.value(named:"TafsirName")
                    tafseerItem.dateOfDeath = row.value(named: "DateOfDeath")
                    tafseerItem.autherName = row.value(named: "AuthName")
                    
                    tafseersList.append(tafseerItem)
                }
            }
            
        } catch  {
            print("could not fetch getMushafTafseers \(error.localizedDescription)")
        }
        return tafseersList
    }
}
