//
//  Villager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Villager: Codable {
    
    let id: Int
    let name: String
    let personality: String
    let birthday: String
    let species: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name-en"
        case birthday = "birthday-string"
        case id, personality, species, gender
    }
}
