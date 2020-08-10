//
//  PlandayAPIClient.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

struct authenticationIDs {
    static var clientID = "b6e01899-f593-4eec-9b34-56fe41a5ecab"
    static var refreshToken = "fQiCPR1SZU-ml3cATrHLiQ"
    static var accessToken = ""
}

class PlandayAPIClient {
    
    private static func authenticate(completion: @escaping (AccessToken?, Error?) -> Void) {
        let url = URL(string: "https://id.planday.com/connect/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        request.httpBody = "client_id=\(authenticationIDs.clientID)&grant_type=refresh_token&refresh_token=\(authenticationIDs.refreshToken)".data(using: .utf8)
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            let accessToken = try! JSONDecoder().decode(AccessToken?.self, from: data!)
            
            DispatchQueue.main.async {
                completion(accessToken, nil)
            }
        }.resume()
    }
    
    static func fetchListData(limit: Int, offset: Int, completion: @escaping (ListEmployeesResponseBody?, Error?) -> Void) {
        let url = URL(string: "https://openapi.planday.com/hr/v1.0/employees?limit=\(limit)&offset=\(offset)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        authenticate { accessToken, authError in
            guard authError == nil else {
                completion(nil, authError!)
                return
            }
            
            guard let accessToken = accessToken?.access_token else {
                fatalError("access token was nil")
            }
            
            authenticationIDs.accessToken = accessToken
            request.allHTTPHeaderFields = ["X-ClientId": "\(authenticationIDs.clientID)", "Authorization": "Bearer \(accessToken)"]
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(nil, error!)
                    return
                }
                let employees = try! JSONDecoder().decode(ListEmployeesResponseBody?.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(employees, nil)
                }
            }.resume()
        }
    }
    
    static func fetchDataDetails(employeeID: Int, completion: @escaping (EmployeeDetailsResponseBody?, Error?) -> Void) {
         
         let url = URL(string: "https://openapi.planday.com/hr/v1.0/employees/\(employeeID)")!
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         
         authenticate { accessToken, authError in
             guard authError == nil else {
                 completion(nil, authError!)
                 return
             }

            request.allHTTPHeaderFields = ["X-ClientId": "\(authenticationIDs.clientID)", "Authorization": "Bearer \(authenticationIDs.accessToken)"]
             
             URLSession.shared.dataTask(with: request) { data, response, error in
                 guard error == nil else {
                     completion(nil, error!)
                     return
                 }
                 
                 let employees = try! JSONDecoder().decode(EmployeeDetailsResponseBody?.self, from: data!)
                 
                 DispatchQueue.main.async {
                     completion(employees, nil)
                 }
             }.resume()
         }
     }
    
    static func updateData(employeeID: String, updateEmployeeRequestBody: UpdateEmployeeRequestBody) {
        let url = URL(string: "https://openapi.planday.com/hr/v1.0/employees/\(employeeID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields  = ["Content-Type": "application/json","X-ClientId": "\(authenticationIDs.clientID)", "Authorization": "Bearer \(authenticationIDs.accessToken)"]
        request.httpBody = try! JSONEncoder().encode(updateEmployeeRequestBody)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                
                if response != nil {
//                    print((response as? HTTPURLResponse)?.statusCode)
                }
            }.resume()
    }
}

