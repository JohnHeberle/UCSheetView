//
//  UCSheetConfigurationTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

final class UCSheetConfigurationTests: XCTestCase {
  let failedCastToIssueReporterMockMessage = "Failed to cast issueReporterMock as IssueReporterMock"

  func testUCSheetConfiguration_DefaultInit() {
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

  func testUCSheetConfiguration_InitWithInvalidDetents() {
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(detents: [], issueReporter: &issueReporterMock)
    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([AlertMessages.invalidDetentsWarning, AlertMessages.invalidDefaultDetentWarning])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }

  func testUCSheetConfiguration_InitWithInvalidDefaultDetent() {
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(
      detents: [.absolute(identifier: .small, height: 100)],
      issueReporter: &issueReporterMock
    )

    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([AlertMessages.invalidDefaultDetentWarning])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }

  func testUCSheetConfiguration_InitWithInvalidLargestUndimmedDetentIdentifier() {
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(
      detents: [.absolute(identifier: .default, height: 100)],
      largestUnDimmedDetentIdentifier: .large,
      issueReporter: &issueReporterMock
    )

    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([AlertMessages.invalidLargestUnDimmedDetentIdentifierWarning])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }

  func testUCSheetConfiguration_InitWithNoDefaultDetent() {
    let noDefaultDetent: [SheetDetent] = [
      .absolute(identifier: .small, height: 200),
      .absolute(identifier: .medium, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(detents: noDefaultDetent, issueReporter: &issueReporterMock)

    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([AlertMessages.invalidDefaultDetentWarning])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }

  func testUCSheetConfiguration_InitWithIdenticalDetentIdentifiers_NonDefault() {
    let identicalDetentIdentifiers: [SheetDetent] = [
      .absolute(identifier: .small, height: 200),
      .absolute(identifier: .small, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(detents: identicalDetentIdentifiers, issueReporter: &issueReporterMock)

    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([
      AlertMessages.identicalDetentIdentifiersWarning,
      AlertMessages.invalidDefaultDetentWarning,
    ])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }

  func testUCSheetConfiguration_InitWithIdenticalDetentIdentifiers_Default() {
    let multipleDefaultDetents: [SheetDetent] = [
      .absolute(identifier: .default, height: 200),
      .absolute(identifier: .default, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let _ = UCSheetView.Configuration(detents: multipleDefaultDetents, issueReporter: &issueReporterMock)

    guard let issueReporterMock = issueReporterMock as? IssueReporterMock else {
      XCTFail(failedCastToIssueReporterMockMessage)
      return
    }
    let expectedWarnings = Set<String>([AlertMessages.identicalDetentIdentifiersWarning])
    XCTAssertEqual(issueReporterMock.reportedIssues, expectedWarnings)
  }
}
