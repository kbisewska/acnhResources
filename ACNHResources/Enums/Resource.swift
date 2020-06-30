//
//  Resource.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 28/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

enum Resource {
    
    case villager(id: Int)
    case fish(id: Int)
    case bug(id: Int)
    case fossil(fileName: String)
    
    var name: String {
        switch self {
        case .villager: return "villagers"
        case .fish: return "fish"
        case .bug: return "bugs"
        case .fossil: return "fossils"
        }
    }
}
