//
//  UserDetailController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 1/2/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
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
           print(data!)
        }failure: { error in
            print(error!)
        }

            
        
        
        
//        { data, status in
//            <#code#>
//        } failure: { error in
//            <#code#>
//        }

}
}
