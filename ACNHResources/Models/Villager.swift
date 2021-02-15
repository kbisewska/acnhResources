//
//  Villager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation
import RealmSwift

final class Villager: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var personality: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var birthdaySimplified: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    
    @objc dynamic var isOwned: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case birthday = "birthday-string"
        case birthdaySimplified = "birthday"
        case id, name, personality, species, gender
    }
    
    private enum NameCodingKeys: String, CodingKey {
        case nameEn = "name-EUen"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        personality = try container.decode(String.self, forKey: .personality)
        birthday = try container.decode(String.self, forKey: .birthday)
        birthdaySimplified = try container.decode(String.self, forKey: .birthdaySimplified)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .nameEn)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(personality, forKey: .personality)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(birthdaySimplified, forKey: .birthdaySimplified)
        try container.encode(species, forKey: .species)
        try container.encode(gender, forKey: .gender)
        
        var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .nameEn)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
