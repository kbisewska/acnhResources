//
//  BugsTableViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 05/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class BugsTableViewControllerSnapshotTests: XCTestCase {
    
    var sut: BugsTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = BugsTableViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBugsTableViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
