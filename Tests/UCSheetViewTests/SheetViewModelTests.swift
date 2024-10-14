//
//  SheetViewModelTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/10/24.
//

import Combine
import XCTest
@testable import UCSheetView

final class SheetViewModelTests: XCTestCase {

  // MARK: Internal

  var subscriptions = Set<AnyCancellable>()
  var detents: [SheetDetent]!

  override func setUp() {
    super.setUp()
    detents = [.absolute(identifier: .default, height: 100), .fractional(identifier: .medium, divisor: 2)]
  }

  override func tearDown() {
    subscriptions.removeAll()
    super.tearDown()
  }

  func testSheetViewModel_Init() {
    let sheetConfiguration = UCSheetView.Configuration(detents: detents, largestUnDimmedDetentIdentifier: .default)
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)
    XCTAssertEqual(viewModel.containerHeight.value, 0)
    XCTAssertEqual(viewModel.sheetHeight.value, 0)
    XCTAssertEqual(viewModel.dimmingAlpha.value, 0)
  }

  func testSheetViewModel_ModifiedContainerHeight() {
    let sheetConfiguration = UCSheetView.Configuration(detents: detents, largestUnDimmedDetentIdentifier: .default)
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)

    viewModel.containerHeight.send(0)
    XCTAssertEqual(viewModel.containerHeight.value, 0)
    viewModel.containerHeight.send(1000)
    XCTAssertEqual(viewModel.containerHeight.value, 1000)
    XCTAssertEqual(viewModel.sheetHeightModifier.value?.updatedHeight, 100)
    XCTAssertEqual(viewModel.sheetHeightModifier.value?.animate, false)
    XCTAssertEqual(viewModel.sheetHeightModifier.value?.state, .finished)
  }

  func testSheetViewModel_Dimming() {
    let sheetConfiguration = UCSheetView.Configuration(detents: detents, largestUnDimmedDetentIdentifier: .default)
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)

    let sheetHeights: [CGFloat] = [90, 100, 300, 500, 510]
    let expectedValues: [CGFloat] = [0.0, 0.0, 0.175, 0.35, 0.35]

    viewModel.containerHeight.send(1000)
    let spy = CurrentValueSubjectSpy(viewModel.dimmingAlpha, expectedValues)

    for sheetHeight in sheetHeights {
      viewModel.sheetHeight.send(sheetHeight)
    }

    wait(for: [spy.expectation], timeout: 5)
  }

  func testSheetViewModel_ModifiedDimming() {
    let sheetConfiguration = UCSheetView.Configuration(
      detents: detents,
      largestUnDimmedDetentIdentifier: .default,
      maxDimmingAlpha: 0.5
    )
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)

    let sheetHeights: [CGFloat] = [90, 100, 300, 500, 510]
    let expectedValues: [CGFloat] = [0.0, 0.0, 0.25, 0.5, 0.5]

    viewModel.containerHeight.send(1000)
    let spy = CurrentValueSubjectSpy(viewModel.dimmingAlpha, expectedValues)

    for sheetHeight in sheetHeights {
      viewModel.sheetHeight.send(sheetHeight)
    }

    wait(for: [spy.expectation], timeout: 5)
  }

  func testSheetViewModel_UnDimmed() {
    let sheetConfiguration = UCSheetView.Configuration(detents: detents)
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)

    let sheetHeights: [CGFloat] = [90, 100, 300, 500, 510]
    let expectedValues: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0]

    viewModel.containerHeight.send(1000)
    let spy = CurrentValueSubjectSpy(viewModel.dimmingAlpha, expectedValues)

    for sheetHeight in sheetHeights {
      viewModel.sheetHeight.send(sheetHeight)
    }

    wait(for: [spy.expectation], timeout: 0.1)
  }

  func testSheetViewModel_UpdateSheetPan() {
    processPanTest(
      panValues: PanRecords.defaultPan.panValues,
      expectedValues: PanRecords.defaultPan.expectedSheetHeightModifierFromViewModel
    )
  }

  func testSheetViewModel_UpdateSheetPan_TopCancelled() {
    processPanTest(
      panValues: PanRecords.topCancelledPan.panValues,
      expectedValues: PanRecords.topCancelledPan.expectedSheetHeightModifierFromViewModel
    )
  }

  func testSheetViewModel_UpdateSheetPan_BottomCancelled() {
    processPanTest(
      panValues: PanRecords.bottomCancelledPan.panValues,
      expectedValues: PanRecords.bottomCancelledPan.expectedSheetHeightModifierFromViewModel
    )
  }

  func testSheetViewModel_UpdateSheetPan_ReverseMidPan() {
    processPanTest(
      panValues: PanRecords.reversedMidPan.panValues,
      expectedValues: PanRecords.reversedMidPan.expectedSheetHeightModifierFromViewModel
    )
  }

  // MARK: Private

  private func processPanTest(panValues: [PanValue], expectedValues: [SheetHeightModifier]) {
    let sheetConfiguration = UCSheetView.Configuration(detents: detents)
    let viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)

    viewModel.containerHeight.send(1000)
    viewModel.sheetHeightModifier.sink { sheetHeightModifier in
      guard let sheetHeightModifier else { return }
      viewModel.sheetHeight.send(sheetHeightModifier.updatedHeight)
    }.store(in: &subscriptions)

    let spy = CurrentValueSubjectSpy(viewModel.sheetHeightModifier, expectedValues)

    for (translation, velocity, state) in panValues {
      viewModel.updateSheetPan(translation: translation, velocity: velocity, state: state)
    }

    wait(for: [spy.expectation], timeout: 0.1)
  }
}
