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
    
    // Registrar usuario
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addEmail: UITextField!
    @IBOutlet weak var addPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var addWorkstation: UITextField!
    @IBOutlet weak var addSalary: UITextField!
    @IBOutlet weak var addBiography: UITextField!
    
    
    // ////// Variables ////// //
    
    // Login y añadir usuario
    var email:String?
    var password:String?
    
    // Recuperar contraseña
    var recoveryEmail : String?
    
    // Añadir usuario
    var name:String?
    var workstation: String?
    var salary: Int?
    var biography: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // Función de login
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
                print(error!)
            }
        }
    }
    
    
    // Función de recuperar contraseña
    @IBAction func buttonPassword(_ sender: UIButton) {
        
        recoveryEmail = emailRecPass.text
        
        if let email = recoveryEmail {
            NetworkingProvider.shared.recoveryPassword(email: email){ user in
                print("Se ha enviado al correo su nueva contraseña")
                
            }failure: { error in
                print(error!)
            }
        }
    }
    
    
    // Función de registrar usuarios
    @IBAction func addUser(_ sender: UIButton) {
        
        name = addName.text
        email = addEmail.text
        password = addPass.text
        workstation = addWorkstation.text
        salary = Int(addSalary.text!)
        biography = addBiography.text
        
        
        
        
        if let name = name,let email = email, let password = password, let workstation = workstation, let salary = salary, let biography = biography   {
            let addUser = AddUser( name: name, email: email, password: password, Workstation: workstation, salary: salary, biography: biography, created_at: nil, updated_at: nil)
            
            let api_token = UserDefaults.standard.string(forKey: "token")
            
            NetworkingProvider.shared.addUser(user: addUser, api_token: api_token!) { user in
                print(user!)
            } failure: { error in
                print(error!)
            }
        }
        
    }
    
        
}
