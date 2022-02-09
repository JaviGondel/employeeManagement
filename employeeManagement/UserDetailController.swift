//
//  UserDetailController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 1/2/22.
//

import UIKit

class UserDetailController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var nameEmployee: UILabel!
    @IBOutlet weak var workstationEmployee: UILabel!
    @IBOutlet weak var biographyEmployee: UILabel!
    @IBOutlet weak var salaryEmployee: UILabel!
    
    
    
    // Variables
    
    var id: Int = 0
    var detailUserName : String? = ""
    var detailUserEmail: String? = ""
    var detailUserWorkstation : String = ""
    var detailUserSalary: String = ""
    var detailUserBiography: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        print(id)
        employeeDetail()
    }
    
    
    func employeeDetail() {
        
        NetworkingProvider.shared.employeeDetail(id: id) { data, status in
            
            if let employeeName = data?.name , let employeeEmail = data?.email , let employeeWorkstation = data?.workstation , let employeeSalary = data?.salary, let employeeBiography = data?.biography{
            
                self.nameEmployee.text = employeeName
                self.workstationEmployee.text = employeeWorkstation
                self.salaryEmployee.text = String(employeeSalary)
                self.biographyEmployee.text = employeeBiography
            }
                
            
        }failure: { error in
            print(error!)
        }

    }
}
