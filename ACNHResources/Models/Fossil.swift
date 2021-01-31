//
//  Fossil.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation
import RealmSwift

final class Fossil: Object, Codable {
    
    @objc dynamic var fileName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    
    @objc dynamic var isOwned: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case fileName = "file-name"
        case name, price
    }
    
    private enum NameCodingKeys: String, CodingKey {
        case nameEn = "name-EUen"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try container.decode(String.self, forKey: .fileName)
        price = try container.decode(Int.self, forKey: .price)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .nameEn)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(price, forKey: .price)
        
        var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .nameEn)
    }
    
    override class func primaryKey() -> String? {
        return "fileName"
    }
}
