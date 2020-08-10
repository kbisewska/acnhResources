//
//  BugDetailsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 10/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class BugDetailsViewControllerSnapshotTests: XCTestCase {
    
    var sut: BugDetailsViewController!
    
    override func setUp() {
        super.setUp()
        Current = .mock
        let bug = Bundle.main.decode([String: Bug].self, from: "bugs.json")
            .compactMap { $0.value }
            .first(where: { $0.id == 1 })!
        sut = BugDetailsViewController(with: bug)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBugDetailsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
