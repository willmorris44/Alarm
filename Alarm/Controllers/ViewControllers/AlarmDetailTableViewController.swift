//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var alarmIsOnButton: UIButton!
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            self.updateViews()
        }
    }
    
    var alarmIsOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleEnabled(for: alarm)
            alarmIsOn = alarm.enabled
        } else {
            alarmIsOn = !alarmIsOn
        }
        setUpAlarm()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = nameTextField.text else { return }
        guard title != "" else { return }
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: datePicker.date, name: title, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: datePicker.date, name: title, enabled: alarmIsOn)
        }
    }
    
    private func updateViews() {
        guard let alarm = alarm else { return }
        
        datePicker.date = alarm.fireDate
        nameTextField.text = alarm.name
        alarmIsOn = alarm.enabled
        setUpAlarm()
        
    }
    
    func setUpAlarm() {
        switch alarmIsOn {
        case true:
            alarmIsOnButton.backgroundColor = .green
            alarmIsOnButton.setTitle("ON", for: .normal)
        case false:
            alarmIsOnButton.backgroundColor = .red
            alarmIsOnButton.setTitle("OFF", for: .normal)
        }
    }


}
