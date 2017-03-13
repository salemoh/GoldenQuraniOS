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
    var guid:String?

    var numberOfPages:Int?
    var type:MushafType?
    var baseImagesDownloadUrl:String?
    var name:String?
    var startOffset:Int?
    var dbName:String?
    
    
    var currentPage:Int?
    var currentSurah:Int?
    var currentAyah:Int?
    var createdAt:Double?
    var updatedAt:Double?
    var logo:UIImage?{
        get {
            let imageName = String(format:"MUSHAF_ICON_%d", self.id!)
            return UIImage(named:imageName)
        }
    }
    
    
//    var logo:String?
    //bookmarks
    //readers[]
    //userLocalDBLocation
    
    func getImageForPage(pageNumber:Int) -> UIImage {
        //0002-phone.png
        let subPath = String(format:"GoldenQuranRes/images/%@_%d",(self.type?.rawValue)!,self.id!)
        let imageName = String(format:"%04d-phone" , pageNumber + self.startOffset! )
        let imageURL = Bundle.main.url(forResource: imageName, withExtension:"png", subdirectory:subPath)
        if let _ = imageURL ,  let image = UIImage(contentsOfFile: imageURL!.path) {
            return image
        }
        return UIImage()
        
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
