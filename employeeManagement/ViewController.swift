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
    var salary: String?
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
                
                if email != user?.email || password != user?.password {
                    self.showToast(message: "Usuario incorrecto", font: .systemFont(ofSize: 12.0))
                }
                
                
                if let user_token = user?.token {
                    debugPrint("New Token: \(user_token)")
                    UserDefaults.standard.set(user_token, forKey: "token")
                    
                    self.performSegue(withIdentifier: "loginSegue", sender: Any?.self)
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
                
                if self.emailRecPass.text == "" {
                    let alert = UIAlertController(title: "Error", message: "Por favor escriba una dirección de correo", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if (user?.email == nil) {
                    let alert = UIAlertController(title: "Email enviado", message: "Se ha enviado el email correctamente a la dirección solicitada", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
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
        salary = addSalary.text
        biography = addBiography.text
        
        if let name = name, let email = email, let password = password, let workstation = workstation, let salary = salary, let biography = biography   {
            
            if (name != "" || email != "" || password != "" || workstation != "" || addSalary.text != "" || biography != "") {
                
                let salaryInt = Int(salary)
               
                let addUser = AddUser( name: name, email: email, password: password, Workstation: workstation, salary: salaryInt, biography: biography, created_at: nil, updated_at: nil)
                
                let api_token = UserDefaults.standard.string(forKey: "token")
                
                
                
                NetworkingProvider.shared.addUser(user: addUser, api_token: api_token!) { user in
                    print(user!)
                    let alert = UIAlertController(title: "Usuario registrado", message: "El usuario se ha registrado correctamente", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } failure: { error in
                    print(error!)
                }
                
            } else {
                let alert = UIAlertController(title: "Error", message: "Error al registrar el nuevo usuario", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Como el usuario en el perfil, me carga antes de guardar el token y cargar el nuevo usuario, hago el segue por código y lo llamo al iniciar sesión
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue"{
            if let destination = segue.destination as? ProfileController{
                
            }
        }
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
