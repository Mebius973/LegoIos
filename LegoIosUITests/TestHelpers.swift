//
//  TestHelpers.swift
//  LegoIosUITests
//
//  Created by Mebius on 26/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest

class TestHelpers {

    public static func waitForElementToDisAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    public static func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    public static func waitForAtLeast1ElementToAppear(_ element: XCUIElementQuery) -> Bool {
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: 30)
        return result == .completed
    }

    public static func checkNoElementOfType(_ element: XCUIElementQuery) -> Bool {
       let predicate = NSPredicate(format: "count == 0")
       let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                   object: element)

       let result = XCTWaiter().wait(for: [expectation], timeout: 30)
       return result == .completed
    }
}
