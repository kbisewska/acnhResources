//
//  FishViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 04/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class FishViewControllerSnapshotTests: XCTestCase {
    
    var sut: FishViewController!
    
    override func setUp() {
        super.setUp()
        sut = FishViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFishViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
