//
//  UpdateEmployeeRequest.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

struct UpdateEmployeeRequestBody: Codable {
    
    let firstName: String
    let lastName: String
    let gender: Gender
}

