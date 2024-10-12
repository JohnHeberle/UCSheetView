//
//  SheetDetent.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Foundation

public struct SheetDetent: Equatable {
  
  // MARK: Lifecycle

  private init(identifier: Identifier, resolver: @escaping ((CGFloat) -> CGFloat)) {
    self.identifier = identifier
    self.resolver = resolver
  }

  // MARK: Internal

  public enum Identifier: String {
    case `default`, xSmall, small, medium, large, xLarge
  }

  public let identifier: Identifier
  let resolver: (CGFloat) -> CGFloat

  public static func fractional(identifier: Identifier, divisor: CGFloat) -> Self {
    guard divisor > 0 else { return .init(identifier: identifier, resolver: { _ in 0 }) }
    return .init(identifier: identifier, resolver: { $0 / divisor })
  }

  public static func absolute(identifier: Identifier, height: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { _ in height })
  }

  public static func absolute(identifier: Identifier, offsetFromTop offset: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { $0 - offset })
  }
  
  public static func == (lhs: SheetDetent, rhs: SheetDetent) -> Bool {
    lhs.identifier == rhs.identifier
  }
}
