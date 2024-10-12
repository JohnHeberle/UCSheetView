//
//  CurrentValueSubjectSpy.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

import XCTest
import Combine

class CurrentValueSubjectSpy<T: Equatable> {
  let expectation: XCTestExpectation
  
  private var expectdValues: [T]
  private var expectationIndex = 0
  
  private var subscriptions = Set<AnyCancellable>()
  
  @discardableResult
  init(_ subject: CurrentValueSubject<T, Never>, _ expectedValues: [T]) {
    self.expectation = XCTestExpectation(description: "ValueSpy \(String(describing: T.self)) expectation")
    self.expectdValues = expectedValues
    
    subject.dropFirst().sink { [weak self] value in
      guard let self else { return }
      XCTAssertEqual(value, expectdValues[expectationIndex])
      expectationIndex += 1
      if expectationIndex == expectdValues.count {
        expectation.fulfill()
      }
    }.store(in: &subscriptions)
  }
}
