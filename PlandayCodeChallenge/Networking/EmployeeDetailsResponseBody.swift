//
//  EmployeeDetailsResponseBody.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

class EmployeeDetailsResponseBody: Codable {
    let employee: Employee
    
    enum CodingKeys: String, CodingKey {
        case employee = "data"
    }
}
