//
//  Hemisphere.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 26/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

enum Hemisphere: CaseIterable {
    
    case north
    case south
    
    var description: String {
        switch self {
        case .north: return "Northern"
        case .south: return "Southern"
        }
    }
}

extension Hemisphere: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0: self = .north
        case 1: self = .south
        default: throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        switch self {
        case .north: try container.encode(0, forKey: .rawValue)
        case .south: try container.encode(1, forKey: .rawValue)
        }
    }
}
