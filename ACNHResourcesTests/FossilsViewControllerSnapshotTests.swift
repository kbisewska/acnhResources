//
//  FossilsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 05/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import RealmSwift
import SnapshotTesting

@testable import ACNHResources

class FossilsViewControllerSnapshotTests: XCTestCase {
    
    var sut: FossilsViewController!
    
    override func setUp() {
        super.setUp()
        sut = FossilsViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFossilsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
