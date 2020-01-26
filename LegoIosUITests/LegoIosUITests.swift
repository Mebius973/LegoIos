//
//  LegoIosUITests.swift
//  LegoIosUITests
//
//  Created by Mebius on 17/10/2018.
//  Copyright © 2018 Mebius. All rights reserved.
//

import XCTest

class LegoIosUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetsShouldAppear() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
    }

    func testSetsShouldHavePullToRefresh() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.cells) {
            XCTAssert(app.activityIndicators.count == 0)
            app.cells.firstMatch.press(forDuration: 0.05, thenDragTo: app.tabBars.firstMatch)
            XCTAssert(app.activityIndicators.count == 1)
            XCTAssert(TestHelpers.waitForElementToDisAppear(app.activityIndicators.firstMatch))
        }
    }

    func testSetsShouldHaveInfiniteScroll() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.cells) {
            XCTAssert(app.activityIndicators.count == 0)
            let initialCellCount = app.cells.count
            app.tables.firstMatch.swipeUp()
            if TestHelpers.waitForElementToAppear(app.activityIndicators.firstMatch) {
                if TestHelpers.waitForElementToDisAppear(app.activityIndicators.firstMatch) {
                    XCTAssert(app.cells.count > initialCellCount)
                }
            }
        }
    }
}
