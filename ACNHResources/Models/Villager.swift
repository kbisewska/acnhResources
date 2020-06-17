//
//  Villager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

class Villager: Codable, Equatable, Hashable {

    let id: Int
    var name: String { nameDetails.nameEn.capitalizeFirstLetter() }
    let personality: String
    let birthday: String
    let birthdaySimplified: String
    let species: String
    let gender: String
    
    var isOwned: Bool = false
    
    private let nameDetails: Name
    
    enum CodingKeys: String, CodingKey {
        case nameDetails = "name"
        case birthday = "birthday-string"
        case birthdaySimplified = "birthday"
        case id, personality, species, gender
    }
    
    private struct Name: Codable {
        let nameEn: String
        
        enum CodingKeys: String, CodingKey {
            case nameEn = "name-EUen"
        }
    }
    
    static func == (lhs: Villager, rhs: Villager) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
