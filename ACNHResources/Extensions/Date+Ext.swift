//
//  Date+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 17/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToDayMonthFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M"
        
        return dateFormatter.string(from: self)
    }
}
