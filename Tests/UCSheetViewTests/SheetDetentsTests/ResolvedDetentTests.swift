//
//  ResolvedDetentTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/14/24.
//

import XCTest
@testable import UCSheetView

final class ResolvedDetentTests: XCTestCase {
  func testResolvedDetent_Init() {
    let resolvedDetent = ResolvedDetent(height: 600, identifier: .userDefined(identifier: .default))
    XCTAssertEqual(resolvedDetent.identifier, .userDefined(identifier: .default))
    XCTAssertEqual(resolvedDetent.height, 600)
  }

  func testResolvedDetent_Sorted() {
    var resolvedDetents: [ResolvedDetent] = [
      .init(height: 600, identifier: .userDefined(identifier: .large)),
      .init(height: 0, identifier: .dismiss),
      .init(height: 200, identifier: .userDefined(identifier: .default)),
      .init(height: 400, identifier: .userDefined(identifier: .medium)),
    ]
    resolvedDetents.sort()

    let expectedResolvedDetents: [ResolvedDetent] = [
      .init(height: 0, identifier: .dismiss),
      .init(height: 200, identifier: .userDefined(identifier: .default)),
      .init(height: 400, identifier: .userDefined(identifier: .medium)),
      .init(height: 600, identifier: .userDefined(identifier: .large)),
    ]

    XCTAssertEqual(resolvedDetents, expectedResolvedDetents)
  }

  func testResolvedDetent_Equality() {
    let equalIdentifiers: [(ResolvedDetent.Identifier, ResolvedDetent.Identifier)] = [
      (.userDefined(identifier: .large), .userDefined(identifier: .large)),
      (.userDefined(identifier: .default), .userDefined(identifier: .default)),
      (.dismiss, .dismiss),
    ]

    for identifier in equalIdentifiers { XCTAssertEqual(identifier.0, identifier.1) }

    let unEqualIdentifiers: [(ResolvedDetent.Identifier, ResolvedDetent.Identifier)] = [
      (.userDefined(identifier: .small), .userDefined(identifier: .xSmall)),
      (.userDefined(identifier: .default), .userDefined(identifier: .medium)),
      (.userDefined(identifier: .xLarge), .userDefined(identifier: .large)),
      (.userDefined(identifier: .default), .dismiss),
      (.dismiss, .userDefined(identifier: .xSmall)),
    ]

    for identifier in unEqualIdentifiers { XCTAssertNotEqual(identifier.0, identifier.1) }
  }
}
