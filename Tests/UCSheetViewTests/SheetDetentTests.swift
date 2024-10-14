//
//  SheetDetentTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class SheetDetentTests: XCTestCase {
  let sheetDetentIdentifiers: [SheetDetent.Identifier] = [.default, .xSmall, .small, .medium, .large, .xLarge]

  func testSheetDetent_FractionalInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: 2)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 50)
    }
  }

  func testSheetDetent_FractionalInvalidInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: 0)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), SheetDetent.minSheetHeight)
    }

    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: -1)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), SheetDetent.minSheetHeight)
    }
  }

  func testSheetDetent_AbsoluteInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .absolute(identifier: identifier, height: 50)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 50)
    }

    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .absolute(identifier: identifier, offsetFromMaxHeight: 20)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 80)
    }
  }

  func testSheetDetent_Equality() {
    var detents: [(SheetDetent, SheetDetent)] = [
      (.absolute(identifier: .default, height: 100), .absolute(identifier: .default, height: 100)),
      (.absolute(identifier: .xSmall, height: 100), .absolute(identifier: .xSmall, height: 50)),
      (.absolute(identifier: .medium, height: 100), .absolute(identifier: .medium, height: 25)),
    ]
    for detent in detents { XCTAssertEqual(detent.0, detent.1) }

    detents = [
      (.absolute(identifier: .default, height: 100), .absolute(identifier: .small, height: 100)),
      (.absolute(identifier: .xSmall, height: 100), .absolute(identifier: .small, height: 50)),
      (.absolute(identifier: .medium, height: 100), .absolute(identifier: .large, height: 25)),
    ]
    for detent in detents { XCTAssertNotEqual(detent.0, detent.1) }
  }
}
