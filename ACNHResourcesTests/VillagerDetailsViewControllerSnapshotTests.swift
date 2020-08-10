//
//  VillagerDetailsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 10/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class VillagerDetailsViewControllerSnapshotTests: XCTestCase {
    
    var sut: VillagerDetailsViewController!
    
    override func setUp() {
        super.setUp()
        Current = .mock
        let villager = Bundle.main.decode([String: Villager].self, from: "villagers.json")
            .compactMap { $0.value }
            .first(where: { $0.id == 1 })!
        sut = VillagerDetailsViewController(with: villager)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testVillagerDetailsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
