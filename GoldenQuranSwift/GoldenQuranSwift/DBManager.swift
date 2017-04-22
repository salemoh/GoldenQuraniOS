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
        
        createMushafBookmarksDB()
    }
    
    //MARK: Functions
    //MARK: ---------------------------
    //MARK: Mushaf Functions
    //MARK: ---------------------------
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
    
    func updateMushaf( mushafObject:Mus7af){
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
    
    func insertNewMushaf( mushafObject:Mus7af){
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
    
    func getMushafTOC( mushaf:Mus7af)->[TableOfContentItem] {
        
        var tableOfContents:[TableOfContentItem] = [TableOfContentItem]()
        do {
            try dbQueue?.inDatabase { db in
                
                let query = String(format:"SELECT MushafID , Page , Juz , Sora , VersesCount , Verse , Hizb , Place FROM tableOfContents WHERE MushafID = %d ORDER BY Page , Sora " , mushaf.id!)
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let tocItem = TableOfContentItem()
                    tocItem.mushafID = row.value(named: "MushafID")
                    tocItem.page = row.value(named: "Page")
                    tocItem.juz = row.value(named: "Juz")
                    tocItem.sora = row.value(named: "Sora")
                    tocItem.versesCount = row.value(named: "VersesCount")
                    tocItem.verse = row.value(named: "Verse")
                    tocItem.hizb = row.value(named: "Hizb")
                    tocItem.place = row.value(named:"Place")
                    
                    tableOfContents.append(tocItem)
                }
            }
            
        } catch  {
            
            print("could not fetch getMushafTOC \(error.localizedDescription)")
            
        }
        return tableOfContents
    }

    //MARK: ---------------------------
    //MARK: Mushaf Highlight
    //MARK: ---------------------------
    func getMus7afHighlightRects( forPage:Int , fromMushafDB:String)->[HighlightRect] {
        
        
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
    
    
    //MARK: ---------------------------
    //MARK: Mushaf Mo3jam
    //MARK: ---------------------------
    func getMushafMo3jam( verseNo:Int , soraNo:Int)->[SearchResult] {
        
        /// not work just query is correct
        var dbMushafMo3jamQueue:DatabaseQueue?
        
        
        do {
            dbMushafMo3jamQueue = try DatabaseQueue(path: Constants.db.mushafMo3jamDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var results:[SearchResult] = []
        do {
            
            try dbMushafMo3jamQueue?.inDatabase { db in
                
                
                let query = String(format:"SELECT Word,  Root , Original , EnglishTranslation , EnglishArabizi , SoraNo , AyahNo , WordNo  FROM QuranMo3jm WHERE  Root != \"\" AND SoraNo = %d AND AyahNo = %d ORDER BY WordNo",soraNo , verseNo)
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let result = SearchResult()
                    result.soraNo = row.value(named:"SoraNo")
                    result.fromVerse = row.value(named:"AyahNo")
                    result.toVerse = row.value(named:"AyahNo")
                    result.content = row.value(named:"Word") + " -> " + row.value(named:"Original") + " -> " + row.value(named:"Root")
                    
                    results.append(result)
                }
            }
            
        } catch  {
            print("could not fetch searchMushafVerse \(error.localizedDescription)")
        }
        return results
    }
    

    //MARK: ---------------------------
    //MARK: Mushaf By Topic
    //MARK: ---------------------------
    
    func getMushafByTopic( formAyah:Int , toAyah:Int, soraNo: Int)->[MushafTopic] {
        
        
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
    
    //MARK: ---------------------------
    //MARK: Mushaf Recitations
    //MARK: ---------------------------
    func getMushafRecitations( mushafType:MushafType) -> [Recitation] {
        
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
    
    //MARK: ---------------------------
    //MARK: Mushaf Tafseers
    //MARK: ---------------------------
    
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
    
    //MARK: ---------------------------
    //MARK: Mushaf Bookmarks
    //MARK: ---------------------------
    
    func createMushafBookmarksDB(){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.create(table: "Bookmark", temporary: false, ifNotExists: true, body: { (t) in
                    t.column("id", .integer).primaryKey(onConflict: .rollback, autoincrement: true)
                    t.column("mushafGuid", .text)
                    t.column("soraNo", .integer)
                    t.column("verseNo", .integer)
                    t.column("page", .integer)
                    t.column("updatedAt", .double)
                    t.column("createdAt", .double)
                })
            }
        } catch  {
            print("Failed to create MushafBookmarksDB \(error.localizedDescription)")
        }
    }
    
    func getMushafBookmarks( mushaf:Mus7af) -> [Bookmark] {
        
        var bookmarksList = [Bookmark]()
        
        do {
            try dbQueueLibrary?.inDatabase { db in
                
                let query = String(format:"SELECT id, mushafGuid,soraNo,verseNo,page,updatedAt,createdAt FROM Bookmark WHERE mushafGuid = '%@' ORDER BY updatedAt DESC",mushaf.guid!)
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let bookmarkItem = Bookmark()
                    bookmarkItem.id = row.value(named: "id")
                    bookmarkItem.mushafGuid = row.value(named: "mushafGuid")
                    bookmarkItem.soraNo = row.value(named: "soraNo")
                    bookmarkItem.verseNo = row.value(named: "verseNo")
                    bookmarkItem.page = row.value(named: "page")
                    bookmarkItem.updatedAt = row.value(named:"updatedAt")
                    bookmarkItem.createdAt = row.value(named: "createdAt")
                    
                    bookmarksList.append(bookmarkItem)
                }
            }
        } catch  {
            print("could not fetch getMushafBookmarks \(error.localizedDescription)")
        }
        return bookmarksList
    }
    
    func deleteMushafBookmark( bookmark:Bookmark){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "DELETE FROM Bookmark WHERE mushafGuid = ? AND id = ?",
                    arguments: [bookmark.mushafGuid , bookmark.id])
                
            }
        } catch  {
            print("Failed to deleteMushafBookmark \(error.localizedDescription)")
        }
        
    }
    
    func deleteAllMushafBookmark( mushaf:Mus7af){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "DELETE FROM Bookmark WHERE mushafGuid = ? ",
                    arguments: [mushaf.guid])
                
            }
        } catch  {
            print("Failed to deleteMushafBookmark \(error.localizedDescription)")
        }
        
    }
    
    func insertNewMushafBookmark( bookmark:Bookmark){
        do {
            try dbQueueLibrary?.inDatabase { db in
                try db.execute(
                    "INSERT INTO Bookmark ( mushafGuid, soraNo, verseNo, page,updatedAt, createdAt ) " +
                    "VALUES ( ?, ?, ? , ? , ?,?)",
                    arguments: [bookmark.mushafGuid,
                                bookmark.soraNo,
                                bookmark.verseNo ,
                                bookmark.page ,
                                bookmark.updatedAt,
                                bookmark.createdAt
                    ])
                
            }
        } catch  {
            print("Failed to insertNewMushafBookmark \(error.localizedDescription)")
        }
        
    }
    
    //MARK: ---------------------------
    //MARK: Search Functions
    //MARK: ---------------------------
    
    func searchMushafByTopic( keyword:String)->[SearchResult] {
        
        
        var dbMushafByTopicQueue:DatabaseQueue?
        
        
        do {
            dbMushafByTopicQueue = try DatabaseQueue(path: Constants.db.mushafByTopicDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var results:[SearchResult] = []
        do {
            
            try dbMushafByTopicQueue?.inDatabase { db in
                
                let query = "SELECT SoraNo,FromAyah,ToAyah,Description ,ColorIndex  FROM data where Description like '%%" + keyword + "%%' order by SoraNo , FromAyah "
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let result = SearchResult()
                    result.soraNo = row.value(named:"SoraNo")
                    result.fromVerse = row.value(named:"FromAyah")
                    result.toVerse = row.value(named:"ToAyah")
                    result.content = row.value(named:"Description")
                    
                    results.append(result)
                }
            }
            
        } catch  {
            print("could not fetch searchMushafByTopic \(error.localizedDescription)")
        }
        return results
    }
    
    func searchMushafVerse( keyword:String)->[SearchResult] {
        
        
        var dbMushafTextQueue:DatabaseQueue?
        
        
        do {
            dbMushafTextQueue = try DatabaseQueue(path: Constants.db.mushafTextDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var results:[SearchResult] = []
        do {
            
            try dbMushafTextQueue?.inDatabase { db in
                
                let query = "SELECT v.sura as SoraNo , v.ayah as FromAyah, v.ayah as ToAyah ,at.text as Description FROM verses v left join arabic_text at on v.ayah = at.ayah AND v.sura = at.sura where v.text like '%%"+keyword+"%%'"
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let result = SearchResult()
                    result.soraNo = row.value(named:"SoraNo")
                    result.fromVerse = row.value(named:"FromAyah")
                    result.toVerse = row.value(named:"ToAyah")
                    result.content = row.value(named:"Description")
                    
                    results.append(result)
                }
            }
            
        } catch  {
            print("could not fetch searchMushafVerse \(error.localizedDescription)")
        }
        return results
    }
    
    func searchMushafMo3jam( keyword:String)->[SearchResult] {
        
        
        var dbMushafMo3jamQueue:DatabaseQueue?
        
        
        do {
            dbMushafMo3jamQueue = try DatabaseQueue(path: Constants.db.mushafMo3jamDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var results:[SearchResult] = []
        do {
            
            try dbMushafMo3jamQueue?.inDatabase { db in
                

                
                let query = "SELECT Word,  Root , Original , EnglishTranslation , EnglishArabizi , SoraNo , AyahNo , WordNo  FROM QuranMo3jm WHERE  Root = '" + keyword + "' ORDER BY SoraNo ,AyahNo"
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let result = SearchResult()
                    result.soraNo = row.value(named:"SoraNo")
                    result.fromVerse = row.value(named:"AyahNo")
                    result.toVerse = row.value(named:"AyahNo")
                    result.content = row.value(named:"Word") + " ← " + row.value(named:"Original") + " ← " + row.value(named:"Root")
                    
                    results.append(result)
                }
            }
            
        } catch  {
            print("could not fetch searchMushafVerse \(error.localizedDescription)")
        }
        return results
    }
    
    
    
    //MARK: ---------------------------
    //MARK: Hadith functions
    //MARK: ---------------------------
    
    func getHadithContent( withGroupId:Int)->[Hadith] {
        
        
        var dbHadithQueue:DatabaseQueue?
        
        
        do {
            dbHadithQueue = try DatabaseQueue(path: Constants.db.hadithFortyDBPath)
        } catch {
            print("could not create/ open dbQueue \(error.localizedDescription)")
        }
        
        
        var results:[Hadith] = []
        do {
            
            try dbHadithQueue?.inDatabase { db in
                
                
                
                let query = "SELECT HadithSummary, HadithFullText, HadithGroupID FROM HadithTable WHERE HadithGroupID = " + String(withGroupId)
                
                let rows = try Row.fetchCursor(db, query)
                
                while let row = try rows.next() {
                    let result = Hadith()
                    result.title = row.value(named:"HadithSummary")
                    result.content = row.value(named:"HadithFullText")
                    result.groupId = row.value(named:"HadithGroupID")
                    
                    results.append(result)
                }
            }
            
        } catch  {
            print("could not fetch searchMushafVerse \(error.localizedDescription)")
        }
        return results
    }
}
