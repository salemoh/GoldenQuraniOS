//
//  BookmarkManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/13/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class BookmarkManager: NSObject {
    
    class func addBookmark( forPage:Int = -1 , forSora:Int = -1 , forVerse:Int = -1){
        let bookmark = Bookmark()
        bookmark.page = forPage
        bookmark.soraNo = forSora
        bookmark.verseNo = forVerse
        bookmark.updatedAt = Date().timeStamp
        bookmark.createdAt = Date().timeStamp
        bookmark.mushafGuid = Mus7afManager.shared.currentMus7af.guid
        
        DBManager.shared.insertNewMushafBookmark(bookmark: bookmark)
    }
    
    class func getMushafBookmarks( mushaf:Mus7af) -> [Bookmark] {
        return DBManager.shared.getMushafBookmarks(mushaf: mushaf)
    }

    class func deleteBookmark( bookmark:Bookmark){
        DBManager.shared.deleteMushafBookmark(bookmark: bookmark)
    }
    
    class func deleteAllBookmarks( mushaf:Mus7af){
        DBManager.shared.deleteAllMushafBookmark(mushaf: mushaf)
    }
    
}
