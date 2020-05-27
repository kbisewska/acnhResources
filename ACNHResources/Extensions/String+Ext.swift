//
//  String+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import CryptoKit
import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
    
    func convertMonths() -> String {
        let months = self.components(separatedBy: "-")
        var monthsNames = [String]()
        
        for month in months {
            switch month {
            case "1": monthsNames.append("January")
            case "2": monthsNames.append("February")
            case "3": monthsNames.append("March")
            case "4": monthsNames.append("April")
            case "5": monthsNames.append("May")
            case "6": monthsNames.append("June")
            case "7": monthsNames.append("July")
            case "8": monthsNames.append("August")
            case "9": monthsNames.append("September")
            case "10": monthsNames.append("October")
            case "11": monthsNames.append("November")
            case "12": monthsNames.append("December")
            default: break
            }
        }
        
        let convertedMonths = monthsNames.joined(separator: " - ")
        return convertedMonths
    }
    
    func sha256() -> String {
        return SHA256.hash(data: Data(self.utf8))
            .compactMap { String(format: "%02x", $0) }.joined()
    }
}
