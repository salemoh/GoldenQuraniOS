//
//  Mus7af.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit


enum MushafType:String{
    case HAFS = "HAFS"
    case WARSH = "WARSH"
}

class Mus7af: NSObject {

    var id:Int?

    var numberOfPages:Int?
    var type:MushafType?
    var baseImagesDownloadUrl:String?
    var name:String?
    var startOffset:Int?
    var dbName:String?
    
    
    var currentPage:Int?
    var currentSurah:Int?
    var currentAyah:Int?
    
    
//    var logo:String?
    //bookmarks
    //readers[]
    //userLocalDBLocation
    
    func getImageForPage(pageNumber:Int) -> UIImage {
        
//        let nsLibraryDirectory = FileManager.SearchPathDirectory.libraryDirectory
//        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
//        let paths               = NSSearchPathForDirectoriesInDomains(nsLibraryDirectory, nsUserDomainMask, true)
//        
//        if let dirPath          = paths.first
//        {
//            let subPath = String(format:"/%@/page%03d",self.type! ,pageNumber )
//            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(subPath)
//            let image    = UIImage(contentsOfFile: imageURL.path)
//            return image!
//        }
        return UIImage()
    }
    
}
