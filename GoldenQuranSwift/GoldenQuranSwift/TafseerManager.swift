//
//  TafseerManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class TafseerManager: NSObject {

    class func getTafseers() -> [Tafseer]{
        return DBManager.shared.getMushafTafseers()
    }
    //static let favouriteTafseer = "FavoriteTafseer"
    //static let activeTafseer = "ActiveTafseer"
    class func setActiveTafseer(tafseer:Tafseer){
        UserDefaults.standard.set(tafseer.id!, forKey: Constants.userDefaultsKeys.activeTafseer)
        UserDefaults.standard.synchronize()
    }
    class func isActiveTafseer(tafseer:Tafseer) -> Bool{
        
        let activeTafseerId = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.activeTafseer)
        
        if activeTafseerId == 0 {
            TafseerManager.setActiveTafseer(tafseer: DBManager.shared.getMushafTafseers()[0])
        }
        
        if tafseer.id == Int(activeTafseerId) {
            return true
        }
        
        
        return false
    }
    
    class func isFavouriteTafseer(tafseer:Tafseer) -> Bool{
        let favoriteTafseers = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteTafseers)
        if let favs = favoriteTafseers as? Array<Int> {
            if favs.contains(tafseer.id!) {
                return true
            }
        }
        return false
    }
    
    class func favouriteTafseers() -> [Int] {
        let favoriteTafseers:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteTafseers) as! [Int]? ?? [Int]()
        return favoriteTafseers
    }
    
    class func addTafseerToFavourite(tafseer:Tafseer) {
        var favoriteTafseers:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteTafseers) as! [Int]? ?? [Int]()
        favoriteTafseers.append(tafseer.id!)
        UserDefaults.standard.set(favoriteTafseers, forKey: Constants.userDefaultsKeys.favouriteTafseers)
        UserDefaults.standard.synchronize()
    }
    
    class func removeTafseerFromFavourite(tafseer:Tafseer) {
        var favoriteTafseers:[Int] = UserDefaults.standard.object(forKey: Constants.userDefaultsKeys.favouriteTafseers) as! [Int]? ?? [Int]()
        if favoriteTafseers.contains(tafseer.id!) {
            let index = favoriteTafseers.index(of: tafseer.id!)!
            favoriteTafseers.remove(at:index)
            UserDefaults.standard.set(favoriteTafseers, forKey: Constants.userDefaultsKeys.favouriteTafseers)
            UserDefaults.standard.synchronize()
        }
        
    }
}
