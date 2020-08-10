//
//  ListEmployeesResponseBody.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

class ListEmployeesResponseBody: Codable {
    let employees: [EmployeeID]
    
    enum CodingKeys: String, CodingKey {
        case employees = "data"
    }
}


