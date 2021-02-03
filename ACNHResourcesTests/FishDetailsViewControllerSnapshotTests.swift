//
//  FishDetailsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 10/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class FishDetailsViewControllerSnapshotTests: XCTestCase {
    
    var sut: FishDetailsViewController!
    
    override func setUp() {
        super.setUp()
        let fish = Bundle.main.decode([String: Fish].self, from: "fish.json")
            .compactMap { $0.value }
            .first(where: { $0.id == 1 })!
        sut = FishDetailsViewController(with: fish)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFishDetailsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
