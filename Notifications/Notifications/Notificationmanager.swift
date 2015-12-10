//
//  Notification.swift
//  Notifications
//
//  Created by Fhict on 10/12/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import UIKit

class Notificationmanager{
    private var dateComp:NSDateComponents
    private var calendar:NSCalendar
    private var scheduledDateTime:NSDate
    
    init() {
        calendar = NSCalendar.currentCalendar()
        dateComp = NSDateComponents()
        scheduledDateTime = calendar.dateFromComponents(dateComp)!
    }
    
    func create(){
        dateComp = NSDateComponents()
        let date:NSDate = NSDate()
        dateComp.year = calendar.component(.Year, fromDate: date)
        dateComp.month = calendar.component(.Month, fromDate: date)
        dateComp.day = calendar.component(.Day, fromDate: date)
        dateComp.hour = calendar.component(.Hour, fromDate: date)
        dateComp.minute = calendar.component(.Minute, fromDate: date) + 1
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        scheduledDateTime = calendar.dateFromComponents(dateComp)!
    }
    
    func schedule(message:String){
        let notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertTitle = "ExtremaHeroes"
        notification.alertBody = message
        notification.fireDate = scheduledDateTime
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
