
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
    
    //Registrar usuarios
    func addUser(user: AddUser, api_token: String, success: @escaping (_ msg: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost:8888/empleados_app/public/api/create?api_token=\(api_token)"
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data {
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    // Listar usuarios ya registrados en la BBDD
    
    func employeeList(success: @escaping (_ data: [User]?, _ status: Int?)->(), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost:8888/empleados_app/public/api/list?api_token=\(api_token!)"
        
        AF.request(url, method: .get) .validate(statusCode: status).responseDecodable(of:ListResponse.self){
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status{
                success(data, statusCode)
            }
            
            if let error = response.error{
                failure(error)
            }
        }
    }
    
    // Listar el detalle de los empleados en función de su puesto de trabajo
    func employeeDetail(id: Int, success: @escaping (_ data: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost:8888/empleados_app/public/api/detail?api_token=\(api_token!)&id=\(id)"
        
        AF.request(url, method: .get).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status {
                success(data, statusCode)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }

}
