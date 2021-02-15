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
    
    // MARK: - Cells Tests
    
    func testResourceCellSubviews() {
        let cell = ResourceCell()
        
        XCTAssertEqual(cell.contentView.subviews, [cell.checkmarkButton, cell.resourceImageView, cell.resourceNameLabel, cell.activityIndicator])
    }
    
    func testVillagerCellSubviews() {
        let cell = VillagerCell()
        
        XCTAssertEqual(cell.contentView.subviews, [cell.nameLabel, cell.birthdayLabel, cell.villagerImageView])
    }
    
    // MARK: - Enums Tests
    
    func testErrorMessageEnumRawValues() {
        let connectionError = ErrorMessage.unableToComplete
        let responseError = ErrorMessage.invalidResponse
        let dataError = ErrorMessage.invalidData
        
        XCTAssertEqual(connectionError.rawValue, "Unable to complete your request. Please check your internet connection.")
        XCTAssertEqual(responseError.rawValue, "Invalid response. Please try again.")
        XCTAssertEqual(dataError.rawValue, "The data received from the server is invalid. Please try again.")
    }
    
    func testHemisphereEnumNumberOfCases() {
        let hemispheres = Hemisphere.allCases
        
        XCTAssertEqual(hemispheres.count, 2)
    }
    
    func testHemisphereEnumCases() {
        let hemispheres = Hemisphere.allCases
        
        XCTAssertEqual(hemispheres, [.north, .south])
    }
    
    func testHemisphereEnumCasesDescription() {
        let northernHemisphere = Hemisphere.north
        let southernHemisphere = Hemisphere.south
        
        XCTAssertEqual(northernHemisphere.description, "Northern")
        XCTAssertEqual(southernHemisphere.description, "Southern")
    }
    
    func testResourceEnumCasesNames() {
        let villager = Resource.villager(id: 1)
        let fish = Resource.fish(id: 1)
        let bug = Resource.bug(id: 1)
        let fossil = Resource.fossil(fileName: "test")
        
        XCTAssertEqual(villager.name, "villagers")
        XCTAssertEqual(fish.name, "fish")
        XCTAssertEqual(bug.name, "bugs")
        XCTAssertEqual(fossil.name, "fossils")
    }
    
    // MARK: - Extensions Tests
    
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
    
    func testAdjustingForAutoLayout() {
        let view = UIView().adjustedForAutoLayout()
        
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testAddingChildToUIViewController() {
        let viewController = UIViewController()
        let childViewController = UIViewController()
        
        viewController.add(childViewController)
        
        XCTAssertEqual(viewController.children, [childViewController])
    }
    
    // MARK: - TabBarController Tests
    
    func testTabBarControllerNumberOfViewControllers() {
        let tabBarController = TabBarController()
        
        XCTAssertEqual(tabBarController.viewControllers?.count, 5)
    }
    
    // MARK: - Views Tests
    
    func testCreditsViewSubviews() {
        let view = CreditsView()
        
        XCTAssertEqual(view.subviews, [view.header, view.scrollView])
        XCTAssertEqual(view.header.subviews, [view.titleLabel])
        XCTAssertEqual(view.scrollView.subviews, [view.container])
        XCTAssertEqual(view.container.subviews, [view.firstCreditsLabel, view.firstSeparator, view.secondCreditsLabel, view.secondSeparator, view.thirdCreditsLabel])
    }
    
    func testDetailsViewSubviews() {
        let view = DetailsView()
        
        XCTAssertEqual(view.subviews, [view.resourceImageView, view.separator, view.resourceNameLabel, view.resourceDetailsLabel])
    }
    
    func testGeneralSettingsViewSubviews() {
        let view = GeneralSettingsView()
        
        XCTAssertEqual(view.subviews, [view.header, view.hemisphereSettingsLabel, view.picker, view.separator, view.resetButton])
        XCTAssertEqual(view.header.subviews, [view.hemisphereLabel])
    }
}
