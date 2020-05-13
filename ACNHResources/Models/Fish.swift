//
//  Fish.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Fish: Codable, Equatable {
    
    static func == (lhs: Fish, rhs: Fish) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    var name: String { nameDetails.nameEn.capitalizeFirstLetter() }
    let availability: Availability
    let price: Int
    let cjPrice: Int
    
    private let nameDetails: Name
    
    enum CodingKeys: String, CodingKey {
        case nameDetails = "name"
        case cjPrice = "price-cj"
        case id, availability, price
    }
    
    private struct Name: Codable {
        let nameEn: String
        
        enum CodingKeys: String, CodingKey {
            case nameEn = "name-en"
        }
    }
    
    struct Availability: Codable {
        let monthNorthern: String?
        let monthSouthern: String?
        let time: String?
        let isAllDay: Bool
        let isAllYear: Bool
        let location: String
        let rarity: String
        
        enum CodingKeys: String, CodingKey {
            case monthNorthern = "month-northern"
            case monthSouthern = "month-southern"
            case time, isAllDay, isAllYear, location, rarity
        }
    }
}


