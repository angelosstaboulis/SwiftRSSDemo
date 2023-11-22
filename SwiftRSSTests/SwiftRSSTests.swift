//
//  SwiftRSSTests.swift
//  SwiftRSSTests
//
//  Created by Angelos Staboulis on 20/11/23.
//

import XCTest
@testable import SwiftRSS

final class SwiftRSSTests: XCTestCase {
    
    let viewModel = RSSViewModel()
    var list:[RSSModel] = []
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let expectation = self.expectation(description: "RSSRequest")

        Task{

            list.append(contentsOf:await viewModel.showRSS(rssString:"https://www.newsit.gr/feed/"))
            XCTAssert(list.count > 0)
            expectation.fulfill()
        }

        wait(for: [expectation],timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
