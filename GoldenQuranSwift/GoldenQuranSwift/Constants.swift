//
//  Constants.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static let iOS_LANGUAGES_KEY = "AppleLanguages"
    static let CURRENT_MUSHAF_KEY = "CurrentMushafGUID"
    
    struct color {
        static let GQBrown = UIColor(red:152.0/255.0 , green:111.0/255.0 , blue:65.0/255.0 , alpha:1.0) as UIColor
    }
    
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
        
        static func mushafWithDBName(name:String) -> String{
            var verifiedName:String = name
            var dbExtenstion:String = "db"
            if name.lowercased().hasSuffix(".db") {
                let range = name.lowercased().range(of: ".db")
                verifiedName = name.replacingCharacters(in: range!, with: "")
                dbExtenstion = name.components(separatedBy: ".").last!
            }
            return Bundle.main.path(forResource: verifiedName, ofType: dbExtenstion, inDirectory: "GoldenQuranRes/db")!
        }
        
        static var mushafByTopicDBPath:String{
            get{ return Bundle.main.path(forResource: "QuranMawdoo3", ofType: "db", inDirectory: "GoldenQuranRes/db/Additions")!}
        }
        
        static var mushafTextDBPath:String{
            get{ return Bundle.main.path(forResource: "quran_text_ar", ofType: "db", inDirectory: "GoldenQuranRes/db")!}
        }
        
        static var mushafMo3jamDBPath:String{
            get{ return Bundle.main.path(forResource: "QuranMo3jm", ofType: "db", inDirectory: "GoldenQuranRes/db/Additions")!}
        }

        static var hadithFortyDBPath:String{
            get{ return Bundle.main.path(forResource: "HadithContent", ofType: "db", inDirectory: "GoldenQuranRes/db")!}
        }
        
        static var mushafRecitationAndTafseerDBPath:String{
            get{return Bundle.main.path(forResource: "TafseerAndRecitation", ofType: "db")!}
        }
        
    }
    
    struct storyboard {
        static let main =  UIStoryboard(name:"main" , bundle:nil)
        static let mushaf = UIStoryboard(name:"Mushaf" , bundle:nil)
    }
    
    struct notifiers {
        static let pageColorChanged = "PAGE_COLOR_CHANGED"
        static let pageHighlightTopicsChanged = "PAGE_HIGHLIGHT_TOPICS_CHANGED"
        
    }
    
    
    struct userDefaultsKeys {
        //Notifications
        static let notificationsFridayDisabled = "NOTIFICATIONS_FRIDAY_DISABLED"
        static let notificationsLongTimeReadingDisabled = "NOTIFICATIONS_LONG_TIME_READING_DISABLED"
        static let notificationsDailyDisabled = "NOTIFICATIONS_DAILY_DISABLED"
        static let notificationsAthanDisabled = "NOTIFICATIONS_ATHAN_DISABLED"
        
        //Notifications Athan (notification by time)
        static let notificationsAthanFajrDisabled = "NOTIFICATIONS_ATHAN_DISABLED_FAJR"
        static let notificationsAthanDouhrDisabled = "NOTIFICATIONS_ATHAN_DISABLED_DUHOR"
        static let notificationsAthanAsrDisabled = "NOTIFICATIONS_ATHAN_DISABLED_ASR"
        static let notificationsAthanMaghribDisabled = "NOTIFICATIONS_ATHAN_DISABLED_MAGHRIB"
        static let notificationsAthanIshaDisabled = "NOTIFICATIONS_ATHAN_DISABLED_ISHA"
        
        
        ///Location Manager
        static let lastKnownLocationLat = "LOCATION_LAST_KNOWN_LAT"
        static let lastKnownLocationLon = "LOCATION_LAST_KNOWN_LON"
        
        //Prayer Times
        static let prayerTimesAdjustmentFajr = "PrayerTimesAdjustments_fajr"
        static let prayerTimesAdjustmentSunrise =  "PrayerTimesAdjustments_sunrise"
        static let prayerTimesAdjustmentDhuhr = "PrayerTimesAdjustments_dhuhr"
        static let prayerTimesAdjustmentAsr = "PrayerTimesAdjustments_asr"
        static let prayerTimesAdjustmentMagrib = "PrayerTimesAdjustments_maghrib"
        static let prayerTimesAdjustmentIsha = "PrayerTimesAdjustments_isha"
        static let prayerTimesSettingsCalculationMethod = "PrayerTimesSettingsCalcultionMethod"
        static let prayerTimesSettingsCalculationMadhab = "PrayerTimesSettingsCalcultionMadhab"
        static let prayerTimesSettingsNotificationSound = "PrayerTimesSettingsNotificationSound"
        
        //// Features menu
        static let highlightMushafByTopicsEnabled = "highlightMushafByTopicsEnabled"
        
        /////Page color
        static let preferedPageBackgroundColor = "PreferedPageBackgroundColor"
        
        
        /////Font size
        static let preferedFontSize = "PreferedFontSize"
        
        //Recitations
        static let favouriteRecitations = "FavoriteRecitations"
        
        //Tafseers
        static let favouriteTafseers = "FavoriteTafseers"
        static let activeTafseer = "ActiveTafseer"
    }
    
}
