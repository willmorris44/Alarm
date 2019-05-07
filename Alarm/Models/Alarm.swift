//
//  Alarm.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
        
    var fireTimeAsString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: fireDate)
    }
    
    init(name: String, fireDate: Date, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
}

extension Alarm: Equatable {
    
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool{
        return lhs.uuid == rhs.uuid
    }
    
}
