//
//  SheetBackgroundViewTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
import Combine
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
  
  @MainActor func testSheetBackgroundInit() {
    let sheetBackground = SheetBackgroundView(sheetConfiguration: sheetConfiguration)
    
    XCTAssertEqual(sheetBackground.backgroundColor, sheetConfiguration.backgroundColor)
    XCTAssertEqual(sheetBackground.layer.cornerRadius, sheetConfiguration.cornerRadius)
    XCTAssertEqual(sheetBackground.layer.shadowColor, sheetConfiguration.shadowColor)
    XCTAssertEqual(sheetBackground.layer.shadowOpacity, sheetConfiguration.shadowOpacity)
    XCTAssertEqual(sheetBackground.layer.shadowRadius, sheetConfiguration.shadowRadius)
  }
  
  @MainActor func testSheetBackGroundUpdatesSheetHeight() {
    let sheetBackground = SheetBackgroundView(sheetConfiguration: sheetConfiguration)
    let sheetHeight = CurrentValueSubject<CGFloat, Never>(0)
    sheetBackground.sheetHeight = sheetHeight
    
    let expectedSheetHeight: CGFloat = 300
    sheetBackground.frame = CGRect(x: 0, y: 0, width: 100, height: expectedSheetHeight)
    sheetBackground.layoutSubviews()
    
    XCTAssertEqual(sheetHeight.value, expectedSheetHeight)
  }
}
