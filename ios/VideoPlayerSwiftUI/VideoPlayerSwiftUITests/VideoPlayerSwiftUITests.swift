//
//  VideoPlayerSwiftUITests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Michael Gauthier on 2021-01-06.
//

import XCTest
@testable import VideoPlayerSwiftUI

class VideoPlayerSwiftUITests: XCTestCase {

    func test_videoApiResponse_with_valid_parameters(){
        
        //Arrange
        let rest = RestManager<[VideoListModel]>()
        let parameters = ["page":"\(1)","page_size": AppConstants.limitPerPage]
        let expectation = self.expectation(description: "valid_parameters")
        
        rest.makeRequest(request : WebAPI().videos(params : parameters, type: .videosList)!) { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[safe: 0]?.title, "About EM:RAP")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0)
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
