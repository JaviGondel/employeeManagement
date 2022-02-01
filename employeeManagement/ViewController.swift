//
//  ViewController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 17/1/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // //////// OUTLETS //////// //
    
    // Login
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    // Recovery Password
    @IBOutlet weak var emailRecPass: UITextField!
    
    
    
    
    // ////// Variables ////// //
    
    var email:String?
    var password:String?
    
    var recoveryEmail : String?
    
    
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
                
                if let user_token = user?.token {
                    UserDefaults.standard.set(user_token, forKey: "token")
                }
            } failure: { error in
                print(error)
            }
        }
    }
    
    @IBAction func buttonPassword(_ sender: UIButton) {
        
        recoveryEmail = emailRecPass.text
        
        if let email = recoveryEmail {
            NetworkingProvider.shared.recoveryPassword(email: email){ user in
                print("Se ha enviado al correo su nueva contraseña")
                
            }failure: { error in
                print(error)
            }
        }
        
        }
        
}
