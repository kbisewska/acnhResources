//
//  Fossil.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Fossil: Codable, Equatable {
    
    static func == (lhs: Fossil, rhs: Fossil) -> Bool {
        lhs.fileName == rhs.fileName
    }
    
    let fileName: String
    var name: String { nameDetails.nameEn.capitalizeFirstLetter() }
    let price: Int
    
    private let nameDetails: Name
    
    enum CodingKeys: String, CodingKey {
        case fileName = "file-name"
        case nameDetails = "name"
        case price
    }
    
    private struct Name: Codable {
        let nameEn: String
        
        enum CodingKeys: String, CodingKey {
            case nameEn = "name-en"
        }
    }
}
