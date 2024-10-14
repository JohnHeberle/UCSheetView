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
    let expectedWarningMessage = """
      UCSheetView Warning:

      `detents` passed to UCSheetView.Configuration is empty

      Default detents: ([.fractional(identifier: .default, divisor: 4), .fractional(identifier: .medium, divisor: 2)]) will be used. Specify the desired detents in the configuration passed to UCSheetView to achieve the expected functionality.
      """
    XCTAssertEqual(AlertMessages.invalidDetentsWarning, expectedWarningMessage)
  }

  func testAlertMessages_IdenticalDetentIdentifiersWarning() {
    let expectedWarningMessage = """
      UCSheetView Warning:

      `detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier

      Enure the specified detents in the configuration passed to UCSheetView do not contain identical identifiers.
      """
    XCTAssertEqual(AlertMessages.identicalDetentIdentifiersWarning, expectedWarningMessage)
  }

  func testAlertMessages_InvalidDefaultDetentWarning() {
    let expectedWarningMessage = """
      UCSheetView Warning:

      `detents` passed to UCSheetView.Configuration does not contain a default detent.

      Enure one of the specified detents in the configuration passed to UCSheetView contains the identifier `.default`.
      """
    XCTAssertEqual(AlertMessages.invalidDefaultDetentWarning, expectedWarningMessage)
  }

  func testAlertMessages_InvalidLargestUnDimmedDetentIdentifierWarning() {
    let expectedWarningMessage = """
      UCSheetView Warning:

      `largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration

      Enure the `largestUnDimmedDetentIdentifier` is an identifier contained in the `detents` passed to the configuration.
      """
    XCTAssertEqual(AlertMessages.invalidLargestUnDimmedDetentIdentifierWarning, expectedWarningMessage)
  }
}
