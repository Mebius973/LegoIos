//
//  PoliciesTests.swift
//  LegoIosUITests
//
//  Created by Mebius on 06/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class PoliciesTests: XCTestCase {
    let app = XCUIApplication()
    let loadingTimeout: TimeInterval = 60

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
        app.launch()
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars))
        app.buttons["info.circle"].tap()
    }

    override func tearDown() {
    }

    func testUIIsComplete() {
        XCTAssert(TestHelpers.waitForElementToAppear(
            app.staticTexts["Privacy Policies for the Brick Browser App"]))
    }
}
