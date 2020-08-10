//
//  AlertTexts.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation

struct AlertTexts {
    
    enum title: String {
        case authenticationError = "Authentication error"
        case missingAccessTokenError = "Missing Access Token"
        case requestError = "URL-Request error"
        case dataFetchError = "Data-fetch error"
    }
    
    enum message: String {
        case authenticationError = "Authentication failed. Check if client-ID and refresh-token is still valid."
        case missingAccessTokenError = "The access token is invalid or missing."
        case requestError = "The URL-Request failed. Check the response for more information."
        case dataFetchError = "The data could not fetched. Check the response or restart the application."
    }
    
}
