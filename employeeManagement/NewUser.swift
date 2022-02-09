//
//  NewUser.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 27/1/22.
//

import Foundation

struct NewUser: Encodable{
    let id: Int?
    let name: String?
    let email: String?
    let password: String?
    let workstation: String?
    let salary: String?
    let biography: String?
    let created_at: Date?
    let updated_at: Date?
}
