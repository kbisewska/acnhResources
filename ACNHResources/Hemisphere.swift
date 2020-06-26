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
