//
//  PartsTests.swift
//  LegoIosUITests
//
//  Created by Mebius on 06/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class PartsTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
        app.launch()
    }

    override func tearDown() {
    }

    func testUIIsComplete() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        app.staticTexts["Toucan"].tap()
        app.buttons["Parts"].tap()
        XCTAssert(TestHelpers.checkNoElementOfType(app.activityIndicators))
        XCTAssert(app.cells.count > 1)
        XCTAssert(app.images.count > 1)
        XCTAssert(app.cells.firstMatch.staticTexts["Name:"].isHittable)
        XCTAssert(app.cells.firstMatch.staticTexts["Color:"].isHittable)
        XCTAssert(app.cells.firstMatch.staticTexts["Quantity:"].isHittable)
        XCTAssert(app.cells.firstMatch.staticTexts["Category:"].isHittable)
        XCTAssert(app.cells.firstMatch.staticTexts["Part Num:"].isHittable)
        XCTAssert(app.buttons["Details"].isHittable)
        XCTAssert(app.buttons["Parts"].isHittable)
        XCTAssert(app.buttons["Parts"].isSelected)
    }

    func testUIShouldNotContainPlaceholder() {
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        app.staticTexts["Toucan"].tap()
        app.buttons["Parts"].tap()
        XCTAssert(!app.staticTexts["Label"].exists)
    }
}
