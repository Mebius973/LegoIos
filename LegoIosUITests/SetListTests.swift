//
//  LegoIosUITests.swift
//  LegoIosUITests
//
//  Created by Mebius on 17/10/2018.
//  Copyright © 2018 Mebius. All rights reserved.
//

import XCTest

class SetListTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
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
    }

    func testSetsShouldAppear() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
    }

    func testSetsShouldHavePullToRefresh() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        XCTAssert(app.activityIndicators.count == 0)
        app.cells.firstMatch.press(forDuration: 0, thenDragTo: app.tabBars.firstMatch)
    }

    func testSetsShouldHaveInfiniteScroll() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        XCTAssert(app.activityIndicators.count == 0)
        let initialCellCount = app.cells.count
        app.swipeUp()
        XCTAssert(TestHelpers.checkNoElementOfType(app.activityIndicators))
        XCTAssert(app.cells.count > initialCellCount)
    }

    func testSetsShouldBeClickable() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        XCTAssert(!app.buttons["Back"].exists)
        app.cells.firstMatch.tap()
        XCTAssert(app.buttons["Back"].exists)
    }

    func testHomeButtonShouldScrollToTop() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        XCTAssert(app.activityIndicators.count == 0)
        let firstCellLabel = app.cells.element(boundBy: 0).staticTexts.firstMatch.label
        app.swipeUp()
        XCTAssert(!app.staticTexts[firstCellLabel].isHittable)
        app.buttons["house.fill"].tap()
        XCTAssert(TestHelpers.waitForElementToBeDisplayed(app.staticTexts[firstCellLabel]))
    }
}
