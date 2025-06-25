//
//  WFCommonTests.swift
//  WFCore
//
//  Created by Kogilapriadarsini Nathan on 25/06/25.
//
import XCTest
@testable import WFCommon

final class WFCommonTests: XCTestCase {
    func testComapreTwoStrings() {
        
        XCTAssertTrue(WFCore().compareStrings("Hello, World!", "Hello, World!"))
    }
}

