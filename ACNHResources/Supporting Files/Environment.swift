//
//  Environment.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 04/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

struct Environment {
    var networkManager: NetworkManager
    var persistenceManager: PersistenceManager
    
    fileprivate static var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["isRunningTests"] != nil
    }
}

extension Environment {
    static var live: Environment {
        Environment(networkManager: NetworkManager(),
                    persistenceManager: PersistenceManager())
    }
    
    static var mock: Environment {
        Environment(networkManager: .mock,
                    persistenceManager: .mock)
    }
}

private(set) var Current: Environment
    = Environment.isRunningTests
    ? .mock
    : .live
