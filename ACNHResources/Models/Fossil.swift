//
//  Fossil.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Fossil: Codable {
    
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name-en"
        case price
    }
}
