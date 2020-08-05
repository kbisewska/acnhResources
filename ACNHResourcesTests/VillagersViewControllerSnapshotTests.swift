//
//  VillagersViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 05/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class VillagersViewControllerSnapshotTests: XCTestCase {
    
    var sut: VillagersViewController!
    
    override func setUp() {
        super.setUp()
        Current = .mock
        sut = VillagersViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testVillagersViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
