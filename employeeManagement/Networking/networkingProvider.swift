
import Foundation
import UIKit
import Alamofire

// En este archivo .swift va toda la lógica del Alamofire


// Gestiona la conexión entre la API y la app
final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    private let BaseURL = "http://localhost:8888/empleados_app/public/api"
    private let status = 200...299
    
    //Función Login
    func login(user: LoginUser, success: @escaping (_ user: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        
        let url = "http://localhost:8888/empleados_app/public/api/login"
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data{
                success(data)
                print(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    // Recuperar contraseña
    func recoveryPassword(email: String, success: @escaping (_ user: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost:8888/empleados_app/public/api/password?email=\(email)"
        
        
        AF.request(url, method: .post).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data{
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
        
    }
    
}
