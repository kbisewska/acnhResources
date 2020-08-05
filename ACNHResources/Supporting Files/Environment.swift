//
//  Environment.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 04/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Environment {
    var networkManager = NetworkManager()
}

extension Environment {
    static var mock: Environment {
        Environment(networkManager: .mock)
    }
}

var Current: Environment = Environment()
