//
//  RecitationDownloadManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/23/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class RecitationDownloadManager: NSObject {

    class func downloadRecitation(recitation:Recitation , soraNo:Int , verseNo:Int){
        
        
        let verseUrlString = recitation.baseUrl! + String(format:"%03d%03d.mp3" ,soraNo,verseNo)
        let savePath = String(format:"%d/%d/", recitation.id!,soraNo)
        let verseName = String(format:"%d.mp3", verseNo)
        
        
        NetworkManager.downloadFile(withUrl: verseUrlString, toPath: savePath, fileName: verseName, completion: {(success:Bool)  -> Void in
            
            if success {
                print("File Downloaded Success " , soraNo , verseNo , recitation.id ?? "")
            } else {
                print("File Downloaded Failed " , soraNo , verseNo , recitation.id ?? "")
            }
            
        })
        
    
        
    }
}
