//
//  SheetBackgroundViewTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/9/24.
//

import Combine
import XCTest
@testable import UCSheetView

final class SheetBackgroundViewTests: XCTestCase {
  let sheetConfiguration = UCSheetView.Configuration(
    detents: [],
    backgroundColor: .red,
    cornerRadius: 10,
    shadowColor: UIColor.black.cgColor,
    shadowOpacity: 0.2,
    shadowRadius: 12
  )

  @MainActor
  func testSheetBackgroundView_Init() {
    let sheetBackground = SheetBackgroundView(sheetConfiguration: sheetConfiguration)

    XCTAssertEqual(sheetBackground.backgroundColor, sheetConfiguration.backgroundColor)
    XCTAssertEqual(sheetBackground.layer.cornerRadius, sheetConfiguration.cornerRadius)
    XCTAssertEqual(sheetBackground.layer.shadowColor, sheetConfiguration.shadowColor)
    XCTAssertEqual(sheetBackground.layer.shadowOpacity, sheetConfiguration.shadowOpacity)
    XCTAssertEqual(sheetBackground.layer.shadowRadius, sheetConfiguration.shadowRadius)
  }

  @MainActor
  func testSheetBackgroundView_UpdateSheetHeight() {
    let sheetBackground = SheetBackgroundView(sheetConfiguration: sheetConfiguration)
    let sheetHeight = CurrentValueSubject<CGFloat, Never>(0)
    let expectedSheetHeight: CGFloat = 300

    sheetBackground.sheetHeight = sheetHeight
    sheetBackground.frame = CGRect(x: 0, y: 0, width: 100, height: expectedSheetHeight)

    XCTAssertEqual(sheetHeight.value, 0)
    sheetBackground.layoutSubviews()
    XCTAssertEqual(sheetHeight.value, expectedSheetHeight)
  }
}
