//
//  ErrorMessage.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    
    case unableToComplete = "No Internet connection found.\nPlease check your connection and try again."
    case invalidResponse = "Invalid response from the server.\nPlease try again."
    case invalidData = "The data received from the server is invalid.\nPlease try again."
}
