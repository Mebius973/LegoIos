//
//  LegoIosTests.swift
//  LegoIosTests
//
//  Created by Mebius on 17/10/2018.
//  Copyright © 2018 Mebius. All rights reserved.
//

import XCTest
@testable import LegoIos

class SetPartsViewModelTests: XCTestCase {
    private let viewModel = SetPartsViewModel()
    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
        XCTAssert(viewModel.count == 0)
    }

}
