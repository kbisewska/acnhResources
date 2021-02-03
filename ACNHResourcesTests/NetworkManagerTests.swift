//
//  NetworkManagerTests.swift
//  ACNHResourcesTests
//
//  Created by Kornelia Bisewska on 06/08/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import ACNHResources

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!

    override func setUp() {
        super.setUp()
        sut = NetworkManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetVillagersDataInvalidResponse() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = [:] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 500, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Villager], ErrorMessage>?
        
        sut.getVillagersData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Villager], ErrorMessage>.failure(.invalidResponse))
    }
    
    func testGetVillagersDataInvalidData() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = ["key1":"value1", "key2":["value2A","value2B"]] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Villager], ErrorMessage>?
        
        sut.getVillagersData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Villager], ErrorMessage>.failure(.invalidData))
    }
    
    func testGetFishDataInvalidResponse() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = [:] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 500, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Fish], ErrorMessage>?
        
        sut.getFishData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Fish], ErrorMessage>.failure(.invalidResponse))
    }
    
    func testGetFishDataInvalidData() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = ["key1":"value1", "key2":["value2A","value2B"]] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Fish], ErrorMessage>?
        
        sut.getFishData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Fish], ErrorMessage>.failure(.invalidData))
    }
    
    func testGetBugsDataInvalidResponse() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = [:] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 500, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Bug], ErrorMessage>?
        
        sut.getBugsData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Bug], ErrorMessage>.failure(.invalidResponse))
    }
    
    func testGetBugsDataInvalidData() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = ["key1":"value1", "key2":["value2A","value2B"]] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Bug], ErrorMessage>?
        
        sut.getBugsData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Bug], ErrorMessage>.failure(.invalidData))
    }
    
    func testGetFossilsDataInvalidResponse() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = [:] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 500, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Fossil], ErrorMessage>?
        
        sut.getFossilsData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Fossil], ErrorMessage>.failure(.invalidResponse))
    }
    
    func testGetFossilsDataInvalidData() {
        stub(condition: isHost("acnhapi.com"), response: { _ in
            let obj = ["key1":"value1", "key2":["value2A","value2B"]] as [String : Any]
            return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        })
        
        let expect = expectation(description: "network response")
        var response: Result<[String: Fossil], ErrorMessage>?
        
        sut.getFossilsData { result in
            response = result
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertEqual(response, Result<[String: Fossil], ErrorMessage>.failure(.invalidData))
    }
}
