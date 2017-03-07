//
//  Constants.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import Foundation

struct Constants {
    
    struct path {
        static let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let library =  NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] as String
        static let tmp = NSTemporaryDirectory()
    }
    
    struct db {
        static let defaultMus7afList = "Mus7af"
        static var defaultMus7afListDBPath:String{
            get{ return  Bundle.main.path(forResource: Constants.db.defaultMus7afList, ofType: "db")!}
        }
        static var userMus7afListDBPath:String{
            get{ return  Constants.path.library.appending("/\(Constants.db.defaultMus7afList).db")}
        }
    }
    
}
