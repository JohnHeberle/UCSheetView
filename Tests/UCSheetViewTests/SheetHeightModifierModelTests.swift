//
//  SheetHeightModifierModelTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/10/24.
//

import XCTest
@testable import UCSheetView

final class SheetHeightModifierModelTests: XCTestCase {

  // MARK: Internal

  var sheetDetentsModel: SheetDetentsModel!
  var sheetHeightModifierModel: SheetHeightModifierModel!

  override func setUp() {
    super.setUp()
    let detents: [SheetDetent] = [.absolute(identifier: .default, height: 100), .fractional(identifier: .medium, divisor: 2)]
    let sheetConfiguration = UCSheetView.Configuration(detents: detents)
    sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)
  }

  func testSheetHeightModifierModel_Update_DefaultPan() {
    sheetHeightModifierModel = SheetHeightModifierModel(sheetDetentsModel: sheetDetentsModel, initialSheetHeight: 100)
    processPanTest(
      panValues: PanRecords.defaultPan.panValues,
      expectedValues: PanRecords.defaultPan.expectedSheetHeightModifierFromModifierModel
    )
  }

  func testSheetHeightModifierModel_Update_TopCancelledPan() {
    sheetHeightModifierModel = SheetHeightModifierModel(sheetDetentsModel: sheetDetentsModel, initialSheetHeight: 500)
    let panValues: [PanValue] = PanRecords.topCancelledPan.panValues.suffix(9)
    processPanTest(panValues: panValues, expectedValues: PanRecords.topCancelledPan.expectedSheetHeightModifierFromModifierModel)
  }

  func testSheetHeightModifierModel_Update_BottomCancelledPan() {
    sheetHeightModifierModel = SheetHeightModifierModel(sheetDetentsModel: sheetDetentsModel, initialSheetHeight: 100)
    processPanTest(
      panValues: PanRecords.bottomCancelledPan.panValues,
      expectedValues: PanRecords.bottomCancelledPan.expectedSheetHeightModifierFromModifierModel
    )
  }

  func testSheetHeightModifierModel_Update_ReversedMidPan() {
    sheetHeightModifierModel = SheetHeightModifierModel(sheetDetentsModel: sheetDetentsModel, initialSheetHeight: 100)
    processPanTest(
      panValues: PanRecords.reversedMidPan.panValues,
      expectedValues: PanRecords.reversedMidPan.expectedSheetHeightModifierFromModifierModel
    )
  }

  // MARK: Private

  private func processPanTest(panValues: [PanValue], expectedValues: [SheetHeightModifier]) {
    var expectedValueIndex = 0

    for (translation, velocity, state) in panValues {
      let updatedSheetHeightModifierModel = sheetHeightModifierModel.update(
        translation: translation,
        velocity: velocity,
        state: state
      )
      XCTAssertEqual(expectedValues[expectedValueIndex], updatedSheetHeightModifierModel)
      expectedValueIndex += 1
    }
  }
}
