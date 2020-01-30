//
//  SearchTests.swift
//  LegoIosUITests
//
//  Created by Mebius on 06/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class SearchTests: XCTestCase {
    let app = XCUIApplication()
    let retry = 3
    var retryCount = 0

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = LaunchArguments.launchLocalArguments
        repeat {
            app.launch()
            if !TestHelpers.waitForAtLeast1ElementToAppear(app.tabBars) {
                relaunchApp()
            } else { break }
        } while retryCount < retry

        retryCount = 0
        app.buttons["magnifyingglass"].tap()
    }

    override func tearDown() {
    }

    func testUIIsComplete() {
        XCTAssert(app.textFields.count == 1)
        XCTAssert(app.buttons["Cancel"].exists)
        XCTAssert(!app.buttons["Cancel"].isEnabled)
    }

    func testWhenEditing() {
        XCTAssert(app.cells.count == 0)
        XCTAssert(app.keyboards.count == 0)
        XCTAssert(!app.buttons["Clear text"].exists)
        let searchField = app.textFields.firstMatch
        searchField.tap()
        XCTAssert(app.keyboards.count == 1)
        XCTAssert(app.buttons["Cancel"].isEnabled)
        searchField.typeText("Test")
        XCTAssert(app.buttons["Clear text"].exists)
        XCTAssert(app.buttons["Clear text"].isEnabled)
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        for iter in 0...app.cells.staticTexts.count - 1 {
            XCTAssert(app.cells.staticTexts.element(boundBy: iter).label.lowercased().contains("test"))
        }
        app.buttons["Clear text"].tap()
        XCTAssert(searchField.label == "")
        XCTAssert(TestHelpers.checkNoElementOfType(app.cells))
        app.buttons["Cancel"].tap()
        XCTAssert(TestHelpers.waitForElementToDisAppear(app.keyboards.firstMatch))
    }

    func testWhenSearching() {
        XCTAssert(app.cells.count == 0)
        XCTAssert(app.keyboards.count == 0)
        XCTAssert(!app.buttons["Clear text"].exists)
        let searchField = app.textFields.firstMatch
        searchField.tap()
        XCTAssert(app.keyboards.count == 1)
        XCTAssert(app.buttons["Cancel"].isEnabled)
        searchField.typeText("Harry")
        XCTAssert(TestHelpers.waitForAtLeast1ElementToAppear(app.cells))
        let previousCount = app.cells.count
        app.keyboards.firstMatch.buttons["Search"].tap()
        XCTAssert(TestHelpers.waitForMoreElementToAppear(app.cells, previousCount: previousCount))
    }

    func testWhenSearchingEmpty() {
        XCTAssert(app.cells.count == 0)
        XCTAssert(app.keyboards.count == 0)
        XCTAssert(!app.buttons["Clear text"].exists)
        let searchField = app.textFields.firstMatch
        searchField.tap()
        XCTAssert(app.keyboards.count == 1)
        XCTAssert(app.buttons["Cancel"].isEnabled)
        app.keyboards.firstMatch.buttons["Search"].tap()
        XCTAssert(app.cells.count == 0)
    }

    func testRelaunchAppWorks() {
        XCTAssert(retryCount == 0)
        relaunchApp()
        XCTAssert(retryCount == 1)
    }

    private func relaunchApp() {
        app.terminate()
        app.launch()
        retryCount += 1
    }
}
