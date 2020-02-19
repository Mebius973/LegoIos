//
//  ContantsTests.swift
//  LegoIosTests
//
//  Created by Mebius on 19/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest
@testable import LegoIos

class ContantsTests: XCTestCase {
    func testApiBaseURlWithoutArgsReturnsTrueURL() {
        XCTAssert(Constants.ApiBaseURL.contains("rebrickable"))
    }

    func testApiBaseURlWithArgsReturnsLocalURL() {
        CommandLine.arguments.append("-runlocal")
        XCTAssert(Constants.ApiBaseURL.contains("localhost"))
        CommandLine.arguments = CommandLine.arguments.filter { $0 != "-runlocal" }
    }
}
