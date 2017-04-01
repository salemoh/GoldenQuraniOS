//
//  PrayerTimesManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/26/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import CoreLocation
import Adhan

class PrayerTimesManager: NSObject {

    /*
    func updatePrayerAdjustment(adjustment:PrayerAdjustments){
        
        UserDefaults.standard.set(adjustment.fajr, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentFajr)
        UserDefaults.standard.set(adjustment.sunrise, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentSunrise)
        UserDefaults.standard.set(adjustment.dhuhr, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentDhuhr)
        UserDefaults.standard.set(adjustment.asr, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentAsr)
        UserDefaults.standard.set(adjustment.maghrib, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentMagrib)
        UserDefaults.standard.set(adjustment.isha, forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentIsha)
        
    }
    */
    
    func getCurrentPrayerAdjstments() -> PrayerAdjustments {
        var adjustments = PrayerAdjustments()
        adjustments.fajr = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentFajr)
        adjustments.sunrise = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentSunrise)
        adjustments.dhuhr = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentDhuhr)
        adjustments.asr = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentAsr)
        adjustments.maghrib = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentMagrib)
        adjustments.isha = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesAdjustmentIsha)
        
        return adjustments
    }
    
    func getCurrentCalculationParams() -> CalculationParameters{
        var params =  CalculationMethod.moonsightingCommittee.params
        //params.madhab = .hanafi
        
        let calculationMethodID = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
        
        switch calculationMethodID {
        case 0,1:
            params = CalculationMethod.muslimWorldLeague.params
        case 2:
            params = CalculationMethod.egyptian.params
        case 3:
            params = CalculationMethod.karachi.params
        case 4:
            params = CalculationMethod.ummAlQura.params
        case 5:
            params = CalculationMethod.gulf.params
        case 6:
            params = CalculationMethod.moonsightingCommittee.params
        case 7:
            params = CalculationMethod.northAmerica.params
        case 8:
            params = CalculationMethod.kuwait.params
        case 9:
            params = CalculationMethod.qatar.params
        default:
            params = CalculationMethod.muslimWorldLeague.params
        }
        
        let calculationMadhabID = UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMadhab)
        switch calculationMadhabID {
        case 1:
            params.madhab = .hanafi
        default:
            params.madhab = .shafi
        }
        return params
    }
    
    func getPrayerTimes(forLocation:CLLocation , forDate:Date = Date()) -> PrayerTimes? {
    
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        
        let coordinates = Coordinates(latitude: forLocation.coordinate.latitude, longitude: forLocation.coordinate.longitude)
        
        var params = getCurrentCalculationParams()
        
        
        params.adjustments = getCurrentPrayerAdjstments()
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            /*
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.timeZone = TimeZone.current
            
            NSLog("fajr %@", formatter.string(from: prayers.fajr))
            NSLog("sunrise %@", formatter.string(from: prayers.sunrise))
            NSLog("dhuhr %@", formatter.string(from: prayers.dhuhr))
            NSLog("asr %@", formatter.string(from: prayers.asr))
            NSLog("maghrib %@", formatter.string(from: prayers.maghrib))
            NSLog("isha %@", formatter.string(from: prayers.isha))
            */
            return prayers
        }
        return nil
    }
    
    func getPrayerTimes()->PrayerTimes?{
        if let location = LocationManager.shared.getLocation() {
            if let prayer = self.getPrayerTimes(forLocation: location) {
                return prayer
            }
        }
        
        return nil
    }
}
