//
//  ErrorMessage.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
}
