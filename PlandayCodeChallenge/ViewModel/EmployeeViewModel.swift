//
//  EmployeeViewModel.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

class EmployeeViewModel {
    
    private let employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    var id: Int {
        return employee.id
    }
    
    var firstName: String {
        return employee.firstName
    }
    
    var lastName: String {
        return employee.lastName
    }
    
    var gender: Gender {
        return employee.gender
    }
    
    var departments: String {
        return "Dept. \(employee.departments)"
    }
}

extension EmployeeViewModel {
  public func configure(_ view: EmployeeCell) {
    view.firstNameLabel.text = firstName
    view.lastNameLabel.text = lastName
    view.genderLabel.text = gender.rawValue
    view.departmentsLabel.text = departments.description
  }
}

