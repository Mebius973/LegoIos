//
//  SetDetailTests.swift
//  LegoIosUITests
//
//  Created by Mebius on 06/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class SetDetailTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
        app.launch()
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        app.staticTexts["Toucan"].tap()
        XCTAssert(TestHelpers.waitForElementToDisAppear(app.activityIndicators.firstMatch))
    }

    override func tearDown() {
    }

    func testUIIsComplete() {
        XCTAssert(app.images.count == 1)
        XCTAssert(app.staticTexts["Set Name:"].isHittable)
        XCTAssert(app.staticTexts["Year:"].isHittable)
        XCTAssert(app.staticTexts["Category:"].isHittable)
        XCTAssert(app.staticTexts["Parts:"].isHittable)
        XCTAssert(app.staticTexts["Set Number:"].isHittable)
        XCTAssert(app.buttons["Details"].isHittable)
        XCTAssert(app.buttons["Details"].isSelected)
        XCTAssert(app.buttons["Parts"].isHittable)
    }
}
