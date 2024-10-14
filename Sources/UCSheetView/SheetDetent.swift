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

  public enum Identifier: String {
    case `default`, xSmall, small, medium, large, xLarge
  }

  public let identifier: Identifier

  public static func fractional(identifier: Identifier, divisor: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      if divisor <= 0 {
        SheetDetent.minSheetHeight
      } else {
        min(max(SheetDetent.minSheetHeight, containerHeight / divisor), containerHeight)
      }
    })
  }

  public static func absolute(identifier: Identifier, height: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      min(max(SheetDetent.minSheetHeight, height), containerHeight)
    })
  }

  public static func absolute(identifier: Identifier, offsetFromTop offset: CGFloat) -> Self {
    .init(identifier: identifier, resolver: { containerHeight in
      min(max(SheetDetent.minSheetHeight, containerHeight - offset), containerHeight)
    })
  }

  public static func ==(lhs: SheetDetent, rhs: SheetDetent) -> Bool {
    lhs.identifier == rhs.identifier
  }

  // MARK: Internal

  static let minSheetHeight: CGFloat = 22

  let resolver: (CGFloat) -> CGFloat

}
