//
//  UCSheetConfigurationTests.swift
//  UCSheetViewTests
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
import IssueReporting
@testable import UCSheetView

final class UCSheetConfigurationTests: XCTestCase {
  let invalidDetentsWarning = "failed - `detents` passed to UCSheetView.Configuration is empty. Default detents will be used but can result in unexpected behavior."
  let identicalDetentIdentifiersWarning = "failed - `detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier. `detents` must use unique identifiers. Any detent identified by a previously used identifier will be ignored."
  let invalidDefaultDetentWarning = "failed - `detents` passed to UCSheetView.Configuration does not contain a default detent. The default detent will be set to the smallest detent in the `detents` array after resolving heights."
  let invalidLargestUnDimmedDetentIdentifierWarning = "failed - `largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration. The specified `largestUnDimmedDetentIdentifier` will be ignored."
  
  func testDefaultSheetConfigurationInit() {
    let detents: [SheetDetent] = [.absolute(identifier: .default, height: 100), .fractional(identifier: .medium, divisor: 2)]
    let sheetConfiguration = UCSheetView.Configuration(detents: detents)
    XCTAssertEqual(sheetConfiguration.detents, detents)
    XCTAssertEqual(sheetConfiguration.maxDimmingAlpha, 0.35)
    XCTAssertEqual(sheetConfiguration.backgroundColor, .white)
    XCTAssertEqual(sheetConfiguration.grabberColor, .lightGray)
    XCTAssertEqual(sheetConfiguration.cornerRadius, 12)
    XCTAssertEqual(sheetConfiguration.shadowColor, UIColor.black.cgColor)
    XCTAssertEqual(sheetConfiguration.shadowOpacity, 0.3)
    XCTAssertEqual(sheetConfiguration.shadowRadius, 12)
  }
  
  func testSheetConfigurationInitWithInvalidDetents() {
    var expectedFailures: Set<String> = [invalidDetentsWarning, invalidDefaultDetentWarning]
    XCTExpectFailure {
      let _ = UCSheetView.Configuration(detents: [])
    } issueMatcher: { issue in
      let issueExpected = expectedFailures.contains(issue.compactDescription)
      expectedFailures.remove(issue.compactDescription)
      return issueExpected
    }
    XCTAssertEqual(expectedFailures.count, 0)
  }
  
  func testSheetConfigurationInitWithInvalidDefaultDetent() {
    var expectedFailures: Set<String> = [invalidDefaultDetentWarning]
    XCTExpectFailure {
      let _ = UCSheetView.Configuration(detents: [.absolute(identifier: .small, height: 100)])
    } issueMatcher: { issue in
      let issueExpected = expectedFailures.contains(issue.compactDescription)
      expectedFailures.remove(issue.compactDescription)
      return issueExpected
    }
    XCTAssertEqual(expectedFailures.count, 0)
  }
  
  func testSheetConfigurationInitWithIdenticalDetents() {
    var expectedFailures: Set<String> = [identicalDetentIdentifiersWarning]
    XCTExpectFailure {
      let _ = UCSheetView.Configuration(detents: [.absolute(identifier: .default, height: 100), .absolute(identifier: .default, height: 200)])
    } issueMatcher: { issue in
      let issueExpected = expectedFailures.contains(issue.compactDescription)
      expectedFailures.remove(issue.compactDescription)
      return issueExpected
    }
    XCTAssertEqual(expectedFailures.count, 0)
    
    expectedFailures = [identicalDetentIdentifiersWarning, invalidDefaultDetentWarning]
    XCTExpectFailure {
      let _ = UCSheetView.Configuration(detents: [.absolute(identifier: .small, height: 100), .absolute(identifier: .small, height: 200)])
    } issueMatcher: { issue in
      let issueExpected = expectedFailures.contains(issue.compactDescription)
      expectedFailures.remove(issue.compactDescription)
      return issueExpected
    }
    XCTAssertEqual(expectedFailures.count, 0)
  }
  
  func testSheetConfigurationInitWithInvalidLargestUndimmedDetentIdentifier() {
    var expectedFailures: Set<String> = [invalidLargestUnDimmedDetentIdentifierWarning]
    XCTExpectFailure {
      let _ = UCSheetView.Configuration(detents: [.absolute(identifier: .default, height: 100)], largestUnDimmedDetentIdentifier: .large)
    } issueMatcher: { issue in
      let issueExpected = expectedFailures.contains(issue.compactDescription)
      expectedFailures.remove(issue.compactDescription)
      return issueExpected
    }
    XCTAssertEqual(expectedFailures.count, 0)
  }
}
