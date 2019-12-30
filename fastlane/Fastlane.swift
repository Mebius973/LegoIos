//
//  Fastlane.swift
//  Fastlane
//
//  Created by Mebius on 17/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import XCTest

class Fastlane: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScreenshotSetsView() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        if waitForAtLeast1ElementToAppear(app.cells) {
            snapshot("SetsTableView")
        }
    }

    func testScreenshotSetDetailView() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        if waitForAtLeast1ElementToAppear(app.cells) {
            app.tables.firstMatch.tap()
            if waitForElementToAppear(app.staticTexts["Set Name:"]) {
                if checkNoElementOfType(app.activityIndicators) {
                    snapshot("SetDetailView")
                }
            }
        }
    }

    func testScreenshotSetPartsView() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        if waitForAtLeast1ElementToAppear(app.cells) {
            app.tables.staticTexts["Creative Bag Charm"].tap()
            if waitForElementToAppear(app.staticTexts["Set Name:"]) {
                if checkNoElementOfType(app.activityIndicators) {
                    app.tabBars.buttons["Parts"].tap()
                    if waitForAtLeast1ElementToAppear(app.cells) {
                        snapshot("SetPartView")
                    }
                }
            }
        }
    }

    private func waitForElementToDisAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    private func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    private func waitForAtLeast1ElementToAppear(_ element: XCUIElementQuery) -> Bool {
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    private func checkNoElementOfType(_ element: XCUIElementQuery) -> Bool {
           let predicate = NSPredicate(format: "count == 0")
           let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                       object: element)

           let result = XCTWaiter().wait(for: [expectation], timeout: 30)
           return result == .completed
       }
}
