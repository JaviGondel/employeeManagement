//
//  ViewController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 17/1/22.
//

import UIKit
import Alamofire

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func login() {
        
        Alamofire.Request("http://localhost:8888/gestion-empleados/public/api/user/login",
            method: .put,
            parameters: ["email":"valor",
                         "password":"valor"],
            encoding: URLEncoding.httpBody)
        
    }


}

