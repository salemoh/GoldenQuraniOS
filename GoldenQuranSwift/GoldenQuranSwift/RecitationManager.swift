//
//  RecitationManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class RecitationManager: NSObject {
    
    class func getRecitations() -> [Recitation]{
        return DBManager.shared.getMushafRecitations(mushafType: Mus7afManager.shared.currentMus7af.type!)
    }
    
    class func getRecitationWithId(id:Int) -> Recitation{
        return DBManager.shared.getMushafRecitationWithID(id: id, mushafType: Mus7afManager.shared.currentMus7af.type!)
    }
    
    class func setActiveRecitation( recitation:Recitation){
        Mus7afManager.shared.currentMus7af.recitationId = recitation.id!
        Mus7afManager.shared.updateMushafValues(mushaf: Mus7afManager.shared.currentMus7af)
    }
    class func isActiveRecitation( recitation:Recitation) -> Bool{
        if recitation.id == Mus7afManager.shared.currentMus7af.recitationId {
            return true
        }
        return false
    }
    
    class func isFavouriteRecitation( recitation:Recitation) -> Bool{
        let favoriteRecitations = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteRecitations)
        if let favs = favoriteRecitations as? Array<Int> {
            if favs.contains(recitation.id!) {
                return true
            }
        }
        return false
    }
    
    class func favouriteRecitations() -> [Int] {
        let favoriteRecitations:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteRecitations) as! [Int]? ?? [Int]()
        return favoriteRecitations
    }
    
    class func addRecitationToFavourite( recitation:Recitation) {
        var favoriteRecitations:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteRecitations) as! [Int]? ?? [Int]()
        favoriteRecitations.append(recitation.id!)
        UserDefaults.standard.set(favoriteRecitations, forKey: Constants.userDefaultsKeys.favouriteRecitations)
        UserDefaults.standard.synchronize()
    }

    class func removeRecitationFromFavourite( recitation:Recitation) {
        var favoriteRecitations:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteRecitations) as! [Int]? ?? [Int]()
        if favoriteRecitations.contains(recitation.id!) {
            let index = favoriteRecitations.index(of: recitation.id!)!
            favoriteRecitations.remove(at:index)
            UserDefaults.standard.set(favoriteRecitations, forKey: Constants.userDefaultsKeys.favouriteRecitations)
            UserDefaults.standard.synchronize()
        }
        
    }
}
