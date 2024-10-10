//
//  SheetDetentTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class SheetDetentTests: XCTestCase {
  let sheetDetentIdentifiers: [SheetDetent.Identifier] = [.default, .xSmall, .small, .medium, .large, .xLarge]
  
  func testFractionalInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: 20)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 5)
    }
  }
  
  func testFractionalInvalidInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: 0)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 0)
    }
    
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .fractional(identifier: identifier, divisor: -1)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 0)
    }
  }
  
  func testAbsoluteInit() {
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .absolute(identifier: identifier, height: 50)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 50)
    }
    
    for identifier in sheetDetentIdentifiers {
      let sheetDetent: SheetDetent = .absolute(identifier: identifier, offsetFromTop: 20)
      XCTAssertEqual(sheetDetent.identifier, identifier)
      XCTAssertEqual(sheetDetent.resolver(100), 80)
    }
  }
  
  func testEquality() {
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
