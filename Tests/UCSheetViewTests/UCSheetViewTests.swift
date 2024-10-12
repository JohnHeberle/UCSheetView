//
//  UCSheetViewTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/10/24.
//

import Combine
import XCTest
@testable import UCSheetView

final class UCSheetViewTests: XCTestCase {
  let defaultFrame = CGRect(x: 0, y: 0, width: 500, height: 1000)
  var ucSheetView: UCSheetView!

  @MainActor
  override func setUp() async throws {
    let detents: [SheetDetent] = [.absolute(identifier: .default, height: 100), .fractional(identifier: .medium, divisor: 2)]
    let sheetConfiguration = UCSheetView.Configuration(detents: detents, largestUnDimmedDetentIdentifier: .default)
    let testView = UIView()
    testView.isUserInteractionEnabled = true
    ucSheetView = UCSheetView(frame: defaultFrame, contentView: testView, sheetConfiguration: sheetConfiguration)
    UCSheetView.setAnimationsEnabled(false)
    ucSheetView.viewModel.setToDefaultDetent()
    ucSheetView.layoutIfNeeded()
  }

  @MainActor
  func testUCSheetViewTests_Init() {
    XCTAssertEqual(ucSheetView.frame, defaultFrame)
    XCTAssertEqual(ucSheetView.viewModel.containerHeight.value, 1000)
  }

  @MainActor
  func testUCSheetViewTests_Point() {
    XCTAssertFalse(ucSheetView.point(inside: CGPoint(x: 50, y: 50), with: nil))
    XCTAssertTrue(ucSheetView.point(inside: CGPoint(x: 450, y: 950), with: nil))
  }
}
