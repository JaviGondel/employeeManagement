//
//  TableViewCell.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 1/2/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userWorkstation: UILabel!
    @IBOutlet weak var userSalary: UILabel!
    
    
    func setCellWithValueOf(_ employee: User){
        writeUser(employeeName: employee.name, employeeWorkstation: employee.workstation, salary: employee.salary)
    }
    
    private func writeUser(employeeName: String?, employeeWorkstation: String?, salary: Int?){
        self.userName.text = employeeName
        self.userWorkstation.text = employeeWorkstation
        if let salary = salary {
            self.userSalary.text = String(salary)
        }
    }
}
