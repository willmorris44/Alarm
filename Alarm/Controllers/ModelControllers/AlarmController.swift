//
//  AlarmController.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import Foundation

class AlarmController {
    
    static var shared = AlarmController()
    
    init() {
        self.alarms = mockAlarms
    }
    
    var alarms = [Alarm]()
    
    var mockAlarms: [Alarm] {
        let alarm1 = Alarm(name: "alarm1", fireDate: Date(), enabled: true)
        let alarm2 = Alarm(name: "alarm2", fireDate: Date(), enabled: true)
        let alarm3 = Alarm(name: "alarm3", fireDate: Date(), enabled: true)
        
        return [alarm1, alarm2, alarm3]
    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
        alarms.append(alarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
}
