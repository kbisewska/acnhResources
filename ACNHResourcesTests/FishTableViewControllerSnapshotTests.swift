//
//  FishTableViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 04/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class FishTableViewControllerSnapshotTests: XCTestCase {
    
    var sut: FishTableViewController!
    
    override func setUp() {
        super.setUp()
        Current = .mock
        sut = FishTableViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFishTableViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
