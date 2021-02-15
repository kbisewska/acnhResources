//
//  FossilsTableViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 05/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import RealmSwift
import SnapshotTesting

@testable import ACNHResources

class FossilsTableViewControllerSnapshotTests: XCTestCase {
    
    var sut: FossilsTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = FossilsTableViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFossilsTableViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
