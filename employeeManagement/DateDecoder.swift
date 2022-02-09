//
//  DateDecoder.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 9/2/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
