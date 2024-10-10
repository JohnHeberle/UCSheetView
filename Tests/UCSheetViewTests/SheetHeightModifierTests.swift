//
//  SheetHeightModifierTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class SheetHeightModifierTests: XCTestCase {
  func testDefaultInit() {
    let sheetHeightModifier = SheetHeightModifier(updatedHeight: 100)
    XCTAssertEqual(sheetHeightModifier.updatedHeight, 100)
    XCTAssertEqual(sheetHeightModifier.velocity, 0)
    XCTAssertTrue(sheetHeightModifier.animate)
    XCTAssertEqual(sheetHeightModifier.state, .started)
  }
  
  func testInit() {
    let sheetHeightModifier = SheetHeightModifier(updatedHeight: 50, velocity: 5, animate: false, state: .continued)
    XCTAssertEqual(sheetHeightModifier.updatedHeight, 50)
    XCTAssertEqual(sheetHeightModifier.velocity, 5)
    XCTAssertFalse(sheetHeightModifier.animate)
    XCTAssertEqual(sheetHeightModifier.state, .continued)
  }
  
  func testGetStateFromPanGuestureRecognizer() {
    let stateMapping: [(UIPanGestureRecognizer.State, SheetHeightModifier.State?)] = [
      (.began, .started),
      (.changed, .continued),
      (.cancelled, .finished),
      (.ended, .finished),
      (.failed, .finished),
      (.possible, nil),
    ]
    for state in stateMapping {
      XCTAssertEqual(SheetHeightModifier.getState(forPanGestureState: state.0), state.1)
    }
  }
}
