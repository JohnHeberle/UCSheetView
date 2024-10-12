//
//  UncheckedSendable.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

#if DEBUG
@propertyWrapper
@usableFromInline
struct UncheckedSendable<Value>: @unchecked Sendable {
  @usableFromInline
  var wrappedValue: Value
  init(wrappedValue value: Value) {
    self.wrappedValue = value
  }
}
#endif
