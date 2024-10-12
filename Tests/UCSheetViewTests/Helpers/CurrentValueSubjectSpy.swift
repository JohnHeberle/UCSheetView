//
//  CurrentValueSubjectSpy.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

import Combine
import XCTest

class CurrentValueSubjectSpy<T: Equatable> {

  // MARK: Lifecycle

  @discardableResult
  init(_ subject: CurrentValueSubject<T, Never>, _ expectedValues: [T]) {
    expectation = XCTestExpectation(description: "ValueSpy \(String(describing: T.self)) expectation")
    expectdValues = expectedValues

    subject.dropFirst().sink { [weak self] value in
      guard let self else { return }
      XCTAssertEqual(value, expectdValues[expectationIndex])
      expectationIndex += 1
      if expectationIndex == expectdValues.count {
        expectation.fulfill()
      }
    }.store(in: &subscriptions)
  }

  // MARK: Internal

  let expectation: XCTestExpectation

  // MARK: Private

  private var expectdValues: [T]
  private var expectationIndex = 0

  private var subscriptions = Set<AnyCancellable>()

}
