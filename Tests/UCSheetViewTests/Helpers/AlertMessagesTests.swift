//
//  AlertMessagesTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class AlertMessagesTests: XCTestCase {
  func testInvalidRequiredInit() {
    var expectedErrorMessage = "required init(coder:) has not been implemented on type UCSheetView.UCSheetView"
    XCTAssertEqual(AlertMessages.invalidRequiredInit(on: UCSheetView.self), expectedErrorMessage)
    expectedErrorMessage = "required init(coder:) has not been implemented on type UCSheetView.SheetBackgroundView"
    XCTAssertEqual(AlertMessages.invalidRequiredInit(on: SheetBackgroundView.self), expectedErrorMessage)
  }
}
