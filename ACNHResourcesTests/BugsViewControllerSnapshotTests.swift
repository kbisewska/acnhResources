//
//  BugsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 05/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class BugsViewControllerSnapshotTests: XCTestCase {
    
    var sut: BugsViewController!
    
    override func setUp() {
        super.setUp()
        sut = BugsViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBugsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
