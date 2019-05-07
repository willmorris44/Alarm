//
//  AlarmController.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import Foundation

class AlarmController: AlarmScheduler {
    
    static var shared = AlarmController()
    
    var alarms = [Alarm]()
    
    var mockAlarms: [Alarm] {
        let alarm1 = Alarm(name: "alarm1", fireDate: Date(), enabled: true)
        let alarm2 = Alarm(name: "alarm2", fireDate: Date(), enabled: true)
        let alarm3 = Alarm(name: "alarm3", fireDate: Date(), enabled: true)
        
        return [alarm1, alarm2, alarm3]
    }
    
    init() {
        //self.alarms = mockAlarms
        alarms = loadFromPersistanceStore()
    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
        alarms.append(alarm)
        
        scheduleUserNotifications(for: alarm)
        saveToPersistanceStore()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        saveToPersistanceStore()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        
        cancelUserNotifications(for: alarm)
        
        saveToPersistanceStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        if alarm.enabled == true {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }

    //MARK: Persistance

    func fileURL() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        let filename = "alarm.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }

    func saveToPersistanceStore() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print("There was an error encoding: \(error) : \(error.localizedDescription)")
        }
    }

    func loadFromPersistanceStore() -> [Alarm] {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            return alarms
        } catch {
            print("There was an error encoding: \(error) : \(error.localizedDescription)")
        }
        return []
    }

}
