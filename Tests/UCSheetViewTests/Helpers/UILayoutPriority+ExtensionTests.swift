//
//  UILayoutPriorityExtensionTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

class UILayoutPriorityExtensionTests: XCTestCase {
  func testConstraintWithPriority() {
    let requiredRawValue = UILayoutPriority.required.rawValue
    let requiredMinusOneRawValue = UILayoutPriority.requiredMinusOne.rawValue
    XCTAssertEqual(requiredRawValue - 1, requiredMinusOneRawValue)
    XCTAssertEqual(requiredMinusOneRawValue, 999)
  }
}
