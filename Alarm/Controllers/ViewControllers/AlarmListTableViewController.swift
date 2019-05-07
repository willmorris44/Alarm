//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Will morris on 5/6/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! SwitchTableViewCell
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.alarm = alarm
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellToDetailView" {
            if let index = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else { return }
                let alarm = AlarmController.shared.alarms[index.row]
                destinationVC.alarm = alarm
            }
        }

    }

}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        
        let alarm = AlarmController.shared.alarms[index.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        //cell.updateViews()
        
    }
    
    
}
