//
//  NotificationsManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import UserNotificationsUI
import UserNotifications

class NotificationsManager: NSObject {

    
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum SearchWeekDayDirection {
        case next
        case previous
        
        var calendarOptions: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
    
    enum SearchWeekDayName:String{
        case sunday = "Sunday"
        case monday = "Monday"
        case tusday = "Tusday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        
        
    }
    
    func getDateOfWeekDay( direction: SearchWeekDayDirection, dayName: SearchWeekDayName, considerToday consider: Bool = false) -> Date {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName.rawValue), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName.rawValue)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = Date()
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        if consider && calendar.component(.weekday, from: today ) == nextWeekDayIndex {
            
            return today
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        let date = calendar.nextDate(after: today, matching: nextDateComponent, matchingPolicy: Calendar.MatchingPolicy.nextTime, repeatedTimePolicy: Calendar.RepeatedTimePolicy.first, direction: direction.calendarOptions)
//        let date = calendar.nextDate(after: today, matching: nextDateComponent , matchingPolicy: direction.calendarOptions)
        
        return date!
    }
    
    
    func fridayNotification(){
        
        var nextFridayTimeStamp = getDateOfWeekDay(direction: .next, dayName: .friday , considerToday: false /*it has issue plese fix*/).timeIntervalSince1970
        nextFridayTimeStamp += 15 * 60 * 60  //3:00 -- 15:00 PM
        
        let nextFridayDate = Date(timeIntervalSince1970:nextFridayTimeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: nextFridayDate)
        
        print(timeStamp)
        
        
        //return
        
        
        //(-360.0 * 60.0) correct : (-530.0 * 60.0)
        let units: Set<Calendar.Component> = [.hour, .day, .month, .year]
        let comps = Calendar.current.dateComponents(units, from: nextFridayDate)
        print (comps, nextFridayDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps,repeats: true)
        
        
        trigger.nextTriggerDate()
        
        let content = UNMutableNotificationContent()
        content.title = "friday"
        content.body = "test body"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "GoldenQuran"
        
        if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        let request = UNNotificationRequest(identifier: "GoldenQuranFridayNotification", content: content, trigger: trigger)
        
        
        //  UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["GoldenQuranFridayNotification"])
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print(" \(error)")
            }
        }
    }
    
    class func scheduleForgetNotification() {
        
        let NotificationForgetDuration = (3 * 24 * 60 * 60)
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(NotificationForgetDuration),repeats: true)
        
        trigger.nextTriggerDate()
        
        let content = UNMutableNotificationContent()
        content.title = "test Reminder"
        content.body = "test body"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "GoldenQuranForgetNotification"
        
        if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        let request = UNNotificationRequest(identifier: "GoldenQuran", content: content, trigger: trigger)
        
        //  UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print(" \(error)")
            }
        }
    }
}
