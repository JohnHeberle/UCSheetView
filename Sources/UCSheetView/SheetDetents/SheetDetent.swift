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

  // MARK: Public

  public enum Identifier {
    case `default`, xSmall, small, medium, large, xLarge

    func resolved() -> ResolvedDetent.Identifier {
      switch self {
      case .default: .userDefined(identifier: .default)
      case .xSmall: .userDefined(identifier: .xSmall)
      case .small: .userDefined(identifier: .small)
      case .medium: .userDefined(identifier: .medium)
      case .large: .userDefined(identifier: .large)
      case .xLarge: .userDefined(identifier: .xLarge)
      }
    }
  }

  public let identifier: Identifier

  public static func fractional(identifier: Identifier, divisor: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      if divisor <= 0 {
        Self.minSheetHeight
      } else {
        min(max(Self.minSheetHeight, containerHeight / divisor), containerHeight)
      }
    })
  }

  public static func absolute(identifier: Identifier, height: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      min(max(Self.minSheetHeight, height), containerHeight)
    })
  }

  public static func absolute(identifier: Identifier, offsetFromMaxHeight offset: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      min(max(Self.minSheetHeight, containerHeight - offset), containerHeight)
    })
  }

  public static func ==(lhs: SheetDetent, rhs: SheetDetent) -> Bool {
    lhs.identifier == rhs.identifier
  }

  // MARK: Internal

  static let minSheetHeight: CGFloat = 22

  let resolver: (CGFloat) -> CGFloat

}
