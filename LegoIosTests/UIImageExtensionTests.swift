//
//  UIImageExtensionTests.swift
//  LegoIosTests
//
//  Created by Mebius on 11/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import XCTest
@testable import LegoIos

class UIImageExtensionTests: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenImageIsSmallerThanRequested() {
        var image = UIImage(named: "spongebob", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let width = image.size.width
        let height = image.size.height
        let scaleFactor = CGFloat(max(width, height) + 1)
        image = image.resizeWithScaleAspectFitMode(to: scaleFactor)!
        XCTAssert(image.size.width == width)
        XCTAssert(image.size.height == height)
    }

    func testResizeWorks() {
        var image = UIImage(named: "spongebob", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let width = image.size.width
        let height = image.size.height
        let requestedSize = CGFloat(max(width, height) / 2)
        image = image.resizeWithScaleAspectFitMode(to: requestedSize)!
        XCTAssert(image.size.width < width)
        XCTAssert(image.size.width == requestedSize)
        XCTAssert(image.size.height == requestedSize)
    }

    func testResizeWideWorks() {
        var image = UIImage(named: "bobross", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let width = image.size.width
        let height = image.size.height
        let requestedSize = CGFloat(max(width, height) / 2)
        image = image.resizeWithScaleAspectFitMode(to: requestedSize)!
        XCTAssert(image.size.width == requestedSize)
        XCTAssert(image.size.height < requestedSize)
        XCTAssert(image.size.height < height)
    }
}
