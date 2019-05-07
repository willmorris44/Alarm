//
//  AlarmScheduler.swift
//  Alarm
//
//  Created by Will morris on 5/7/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
    
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "\(alarm.name) is going off"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: alarm.fireDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("There was an error processing request: \(error) : \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
}
