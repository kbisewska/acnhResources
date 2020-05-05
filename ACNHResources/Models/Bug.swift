//
//  Bug.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Bug: Codable {
    
    let id: String
    let name: String
    let availabilityNorthern: String
    let availabilitySouthern: String
    var time: String?
    var isAllDay: Bool?
    let location: String
    let rarity: String
    let price: Int
    let flickPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name-en"
        case availabilityNorthern = "month-northern"
        case availabilitySouthern = "month-southern"
        case flickPrice = "price-flick"
        case id, time, isAllDay, location, rarity, price
    }
}
