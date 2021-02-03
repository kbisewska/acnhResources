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
    var persistenceManager = PersistenceManager()
}

extension Environment {
    static var mock: Environment {
        Environment(networkManager: .mock,
                    persistenceManager: .mock)
    }
}

var Current: Environment = Environment() {
    didSet (newValue) {
        Current = newValue
        print(Current.persistenceManager is PersistenceManagerMock)
        print(newValue)
    }
}
