//
//  SheetDetentsModelTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/10/24.
//

import XCTest
@testable import UCSheetView

final class SheetDetentsModelTests: XCTestCase {

  // MARK: Internal

  typealias DetentTest = (CGFloat, SheetHeightModifier.Direction, SheetDetent.ResolvedIdentifier)
  typealias DimmmingTest = (CGFloat, CGFloat)

  let basicDetents: [SheetDetent] = [
    .absolute(identifier: .default, height: 200),
    .absolute(identifier: .medium, height: 400),
    .absolute(identifier: .large, height: 600),
  ]

  func testSheetDetentsModel_GetDetent() {
    let sheetConfiguration = UCSheetView.Configuration(detents: basicDetents)
    var sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)
    XCTAssertEqual(sheetDetentsModel.minDetent.height, 200)
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 600)
    XCTAssertEqual(sheetDetentsModel.selectedDetent, .userDefined(identifier: .default))
    XCTAssertNil(sheetDetentsModel.dimmingHeights)

    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .default)), 200)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .medium)), 400)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .large)), 600)

    let defaultDetentsTests: [DetentTest] = [
      (190, .up, .userDefined(identifier: .default)),
      (190, .down, .userDefined(identifier: .default)),
      (210, .up, .userDefined(identifier: .default)),
      (210, .down, .userDefined(identifier: .default)),
      (300, .up, .userDefined(identifier: .medium)),
      (300, .down, .userDefined(identifier: .default)),
      (500, .up, .userDefined(identifier: .large)),
      (500, .down, .userDefined(identifier: .medium)),
    ]

    processDetentTest(sheetDetentsModel: sheetDetentsModel, detentTests: defaultDetentsTests)

    sheetDetentsModel.selectedDetent = .userDefined(identifier: .medium)
    let mediumDetentsTests: [(CGFloat, SheetHeightModifier.Direction, SheetDetent.ResolvedIdentifier)] = [
      (390, .up, .userDefined(identifier: .medium)),
      (390, .down, .userDefined(identifier: .medium)),
      (410, .up, .userDefined(identifier: .medium)),
      (410, .down, .userDefined(identifier: .medium)),
      (300, .up, .userDefined(identifier: .medium)),
      (300, .down, .userDefined(identifier: .default)),
      (500, .up, .userDefined(identifier: .large)),
      (500, .down, .userDefined(identifier: .medium)),
    ]

    processDetentTest(sheetDetentsModel: sheetDetentsModel, detentTests: mediumDetentsTests)

    sheetDetentsModel.selectedDetent = .userDefined(identifier: .large)
    let largeDetentsTests: [DetentTest] = [
      (590, .up, .userDefined(identifier: .large)),
      (590, .down, .userDefined(identifier: .large)),
      (610, .up, .userDefined(identifier: .large)),
      (610, .down, .userDefined(identifier: .large)),
      (500, .up, .userDefined(identifier: .large)),
      (500, .down, .userDefined(identifier: .medium)),
      (300, .up, .userDefined(identifier: .medium)),
      (300, .down, .userDefined(identifier: .default)),
    ]

    processDetentTest(sheetDetentsModel: sheetDetentsModel, detentTests: largeDetentsTests)
  }

  func testSheetDetentsModel_Dimming() {
    var sheetConfiguration = UCSheetView.Configuration(detents: basicDetents)
    var sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)
    XCTAssertNil(sheetDetentsModel.dimmingHeights)

    sheetConfiguration = UCSheetView.Configuration(detents: basicDetents, largestUnDimmedDetentIdentifier: .medium)
    sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)
    XCTAssertEqual(sheetDetentsModel.dimmingHeights?.largestUndimmedHeight, 400)
    XCTAssertEqual(sheetDetentsModel.dimmingHeights?.smallestDimmedHeight, 600)
  }

  func testSheetDetentsModel_MinMax() {
    let sheetConfiguration = UCSheetView.Configuration(detents: basicDetents)
    let sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)
    XCTAssertEqual(sheetDetentsModel.minDetent.identifier, .userDefined(identifier: .default))
    XCTAssertEqual(sheetDetentsModel.minDetent.height, 200)
    XCTAssertEqual(sheetDetentsModel.maxDetent.identifier, .userDefined(identifier: .large))
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 600)
  }

  func testSheetDetentsModel_InitWithNoDefaultDetent() {
    let noDefaultDetent: [SheetDetent] = [
      .absolute(identifier: .small, height: 200),
      .absolute(identifier: .medium, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let sheetConfiguration = UCSheetView.Configuration(detents: noDefaultDetent, issueReporter: &issueReporterMock)
    let sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)

    XCTAssertEqual(sheetDetentsModel.minDetent.height, 200)
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 600)
    XCTAssertEqual(sheetDetentsModel.selectedDetent, .userDefined(identifier: .default))
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .default)), 200)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .medium)), 400)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .large)), 600)
  }

  func testSheetDetentsModel_InitWithIdenticalDetentIdentifiers_NonDefault() {
    let identicalDetentIdentifiers: [SheetDetent] = [
      .absolute(identifier: .small, height: 200),
      .absolute(identifier: .small, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let sheetConfiguration = UCSheetView.Configuration(detents: identicalDetentIdentifiers, issueReporter: &issueReporterMock)
    let sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)

    XCTAssertEqual(sheetDetentsModel.minDetent.height, 200)
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 600)
    XCTAssertEqual(sheetDetentsModel.selectedDetent, .userDefined(identifier: .default))
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .default)), 200)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .large)), 600)
  }

  func testSheetDetentsModel_InitWithIdenticalDetentIdentifiers_Default() {
    let multipleDefaultDetents: [SheetDetent] = [
      .absolute(identifier: .default, height: 200),
      .absolute(identifier: .default, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    var issueReporterMock: any IssueReportingProtocol = IssueReporterMock()
    let sheetConfiguration = UCSheetView.Configuration(detents: multipleDefaultDetents, issueReporter: &issueReporterMock)
    let sheetDetentsModel = SheetDetentsModel(containerHeight: 1000, sheetConfiguration: sheetConfiguration)

    XCTAssertEqual(sheetDetentsModel.minDetent.height, 200)
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 600)
    XCTAssertEqual(sheetDetentsModel.selectedDetent, .userDefined(identifier: .default))
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .default)), 200)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .large)), 600)
  }

  func testSheetDetentsModel_InitWithZeroContainerHeight() {
    let basicDetents: [SheetDetent] = [
      .absolute(identifier: .default, height: 200),
      .absolute(identifier: .medium, height: 400),
      .absolute(identifier: .large, height: 600),
    ]
    let sheetConfiguration = UCSheetView.Configuration(detents: basicDetents)
    let sheetDetentsModel = SheetDetentsModel(containerHeight: 0, sheetConfiguration: sheetConfiguration)
    XCTAssertEqual(sheetDetentsModel.minDetent.height, 0)
    XCTAssertEqual(sheetDetentsModel.maxDetent.height, 0)
    XCTAssertEqual(sheetDetentsModel.selectedDetent, .userDefined(identifier: .default))

    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .default)), 0)
    XCTAssertEqual(sheetDetentsModel.getDetentHeight(forDetent: .userDefined(identifier: .medium)), 0)
  }

  // MARK: Private

  private func processDetentTest(sheetDetentsModel: SheetDetentsModel, detentTests: [DetentTest]) {
    for (height, direction, expectedDetentIdentifier) in detentTests {
      XCTAssertEqual(
        sheetDetentsModel.getDetent(forHeight: height, inDirection: direction),
        expectedDetentIdentifier,
        "getDetent(forHeight: \(height), inDirection: \(direction)) expected return of \(sheetDetentsModel.getDetent(forHeight: height, inDirection: direction)) but got \(expectedDetentIdentifier)."
      )
    }
  }

}
