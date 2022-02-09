//
//  ProfileController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 9/2/22.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileUser()
    }

    // Outlets
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileWorkstation: UILabel!
    @IBOutlet weak var profileBiography: UILabel!
    @IBOutlet weak var profileSalary: UILabel!
    

    // Variables

    var profileDataName : String? = ""
    var profileDataWorkstation : String? = ""
    var profileDataSalary : Int?
    var profileDataBiography: String? = ""

    func profileUser(){
        NetworkingProvider.shared.employeeProfile { data, status in
            if let profileName = data?.name , let profileWorkstation = data?.workstation , let profileSalary = data?.salary, let profileBiography = data?.biography{
                
                self.profileName.text = profileName
                self.profileWorkstation.text = profileWorkstation
                self.profileSalary.text = String(profileSalary)
                self.profileBiography.text = profileBiography
            }
        } failure: { error in
            print(error)
        }
    }
}
