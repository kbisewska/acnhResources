//
//  FossilDetailsViewControllerSnapshotTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 10/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import ACNHResources

class FossilDetailsViewControllerSnapshotTests: XCTestCase {
    
    var sut: FossilDetailsViewController!
    
    override func setUp() {
        super.setUp()
        Current = .mock
        let fossil = Bundle.main.decode([String: Fossil].self, from: "fossils.json")
            .compactMap { $0.value }
            .first(where: { $0.fileName == "acanthostega" })!
        sut = FossilDetailsViewController(with: fossil)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFossilDetailsViewController() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneXr))
    }
}
