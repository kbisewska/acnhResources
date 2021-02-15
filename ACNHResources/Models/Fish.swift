//
//  Fish.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation
import RealmSwift

final class Fish: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var monthNorthern: String?
    @objc dynamic var monthSouthern: String?
    @objc dynamic var time: String?
    @objc dynamic var isAllDay: Bool = false
    @objc dynamic var isAllYear: Bool = false
    @objc dynamic var location: String = ""
    @objc dynamic var rarity: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var cjPrice: Int = 0
    
    @objc dynamic var isOwned: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case cjPrice = "price-cj"
        case id, name, availability, price
    }
    
    private enum NameCodingKeys: String, CodingKey {
        case nameEn = "name-EUen"
    }
    
    private enum AvailabilityCodingKeys: String, CodingKey {
        case monthNorthern = "month-northern"
        case monthSouthern = "month-southern"
        case time, isAllDay, isAllYear, location, rarity
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Int.self, forKey: .price)
        cjPrice = try container.decode(Int.self, forKey: .cjPrice)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .nameEn)
        
        let availabilityContainer = try container.nestedContainer(keyedBy: AvailabilityCodingKeys.self, forKey: .availability)
        monthNorthern = try availabilityContainer.decode(String.self, forKey: .monthNorthern)
        monthSouthern = try availabilityContainer.decode(String.self, forKey: .monthSouthern)
        time = try availabilityContainer.decode(String.self, forKey: .time)
        isAllDay = try availabilityContainer.decode(Bool.self, forKey: .isAllDay)
        isAllYear = try availabilityContainer.decode(Bool.self, forKey: .isAllYear)
        location = try availabilityContainer.decode(String.self, forKey: .location)
        rarity = try availabilityContainer.decode(String.self, forKey: .rarity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(price, forKey: .price)
        try container.encode(cjPrice, forKey: .cjPrice)
        
        var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .nameEn)
        
        var availabilityContainer = container.nestedContainer(keyedBy: AvailabilityCodingKeys.self, forKey: .availability)
        try availabilityContainer.encode(monthNorthern, forKey: .monthNorthern)
        try availabilityContainer.encode(monthSouthern, forKey: .monthSouthern)
        try availabilityContainer.encode(time, forKey: .time)
        try availabilityContainer.encode(isAllDay, forKey: .isAllDay)
        try availabilityContainer.encode(isAllYear, forKey: .isAllYear)
        try availabilityContainer.encode(location, forKey: .location)
        try availabilityContainer.encode(rarity, forKey: .rarity)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


