//
//  AlertMessagesTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class AlertMessagesTests: XCTestCase {
  func testAlertMessages_InvalidRequiredInit() {
    var expectedErrorMessage = "required init(coder:) has not been implemented on type UCSheetView.UCSheetView"
    XCTAssertEqual(AlertMessages.invalidRequiredInit(on: UCSheetView.self), expectedErrorMessage)
    expectedErrorMessage = "required init(coder:) has not been implemented on type UCSheetView.SheetBackgroundView"
    XCTAssertEqual(AlertMessages.invalidRequiredInit(on: SheetBackgroundView.self), expectedErrorMessage)
  }

  func testAlertMessages_InvalidDetentsWarning() {
    let expectedWarningMessage =
      "`detents` passed to UCSheetView.Configuration is empty. Default detents will be used but can result in unexpected behavior."
    XCTAssertEqual(AlertMessages.invalidDetentsWarning, expectedWarningMessage)
  }

  func testAlertMessages_IdenticalDetentIdentifiersWarning() {
    let expectedWarningMessage =
      "`detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier. `detents` must use unique identifiers. Any detent identified by a previously used identifier will be ignored."
    XCTAssertEqual(AlertMessages.identicalDetentIdentifiersWarning, expectedWarningMessage)
  }

  func testAlertMessages_InvalidDefaultDetentWarning() {
    let expectedWarningMessage =
      "`detents` passed to UCSheetView.Configuration does not contain a default detent. The default detent will be set to the smallest detent in the `detents` array after resolving heights."
    XCTAssertEqual(AlertMessages.invalidDefaultDetentWarning, expectedWarningMessage)
  }

  func testAlertMessages_InvalidLargestUnDimmedDetentIdentifierWarning() {
    let expectedWarningMessage =
      "`largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration. The specified `largestUnDimmedDetentIdentifier` will be ignored."
    XCTAssertEqual(AlertMessages.invalidLargestUnDimmedDetentIdentifierWarning, expectedWarningMessage)
  }
}
