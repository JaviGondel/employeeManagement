//
//  Answer.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 27/1/22.
//

import Foundation

struct Response: Decodable{
    let status: Int?
    let data: User?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

struct ListResponse: Decodable{
    let status: Int?
    let data: [User]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
