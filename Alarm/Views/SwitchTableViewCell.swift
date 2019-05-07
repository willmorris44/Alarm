//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        guard let delegate = delegate else { return }
        
        delegate.switchCellSwitchValueChanged(cell: self)
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
}
