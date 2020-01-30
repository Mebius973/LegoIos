//
//  TabBarTests.swift
//  LegoIosUITests
//
//  Created by Mebius on 06/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class TabBarTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
        app.launch()
    }

    override func tearDown() {
    }

    func testTabBarShouldHaveHomeIcon() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars) {
            XCTAssert(app.buttons["house.fill"].isHittable)
        }
    }

    func testTabBarShouldHaveHomeIconSelectedByDefault() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars) {
            XCTAssert(app.buttons["house.fill"].isSelected)
        }
    }

    func testTabBarShouldHaveSearchIcon() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars) {
            XCTAssert(app.buttons["magnifyingglass"].isHittable)
        }
    }

    func testTabBarShouldHaveInfoIcon() {
        if TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars) {
            XCTAssert(app.buttons["info.circle"].isHittable)
        }
    }
}
