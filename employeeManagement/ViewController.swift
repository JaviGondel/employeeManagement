//
//  ViewController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 17/1/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    var email:String?
    var password:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        email = emailTextField.text
        password = PasswordTextField.text
        
        
            
            if let email = email, let password = password {
                let LoginUser = LoginUser(email: email, password: password)
                
                NetworkingProvider.shared.login(user: LoginUser) { user in
                    //                print(user)
                    
                    if let user_token = user?.token {
                        UserDefaults.standard.set(user_token, forKey: "token")
                    }
                } failure: { error in
                    print(error)
                }
                
                
            }
    }
        
    }
