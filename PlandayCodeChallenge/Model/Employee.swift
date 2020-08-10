//
//  Employee.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

struct Employee: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var gender: Gender
    let departments: [Int]
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}

struct EmployeeID: Codable {
    var id: Int
}
