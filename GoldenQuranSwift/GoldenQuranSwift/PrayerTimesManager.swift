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

    func updatePrayerAdjustment(){
    
    }
    
    func getPrayerTimes(forLocation:CLLocation){
    
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        
        let coordinates = Coordinates(latitude: forLocation.coordinate.latitude, longitude: forLocation.coordinate.longitude)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = .hanafi
        
        let adjusments = PrayerAdjustments()
        //adjusments.asr =
        params.adjustments = adjusments
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.timeZone = TimeZone.current
            
            NSLog("fajr %@", formatter.string(from: prayers.fajr))
            NSLog("sunrise %@", formatter.string(from: prayers.sunrise))
            NSLog("dhuhr %@", formatter.string(from: prayers.dhuhr))
            NSLog("asr %@", formatter.string(from: prayers.asr))
            NSLog("maghrib %@", formatter.string(from: prayers.maghrib))
            NSLog("isha %@", formatter.string(from: prayers.isha))
        }
        
    }
}
