//
//  ACNHResourcesTests.swift
//  ACNHResourcesTests
//
//  Created by Kora on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
@testable import ACNHResources

class ACNHResourcesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateConverter() {
        let date = Date.init(timeIntervalSince1970: 0)
        
        XCTAssertEqual(date.convertToDayMonthFormat(), "1/1")
    }
    
    func testCapitalizingFirstLetter() {
        let word = "test"
        
        XCTAssertEqual(word.capitalizeFirstLetter(), "Test")
    }
    
    func testSHA256Hash() {
        let word = "test"
        
        XCTAssertEqual(word.sha256(), "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    }
    
    func testAddingSubviews() {
        let view = UIView()
        let subview1 = UIView()
        let subview2 = UIView()
        let subview3 = UIView()
        
        view.addSubviews(subview1, subview2, subview3)
        
        XCTAssertEqual(view.subviews, [subview1, subview2, subview3])
    }
    
    func testAddingChildToUIViewController() {
        let viewController = UIViewController()
        let childViewController = UIViewController()
        
        viewController.add(childViewController)
        
        XCTAssertEqual(viewController.children, [childViewController])
    }
}
