//
//  ResolvedDetent.swift
//  UCSheetView
//
//  Created by John Heberle on 10/14/24.
//

import Foundation

struct ResolvedDetent: Comparable, Equatable {
  enum Identifier: Hashable {
    case dismiss
    case userDefined(identifier: SheetDetent.Identifier)
  }

  let height: CGFloat
  let identifier: Identifier

  static func <(lhs: ResolvedDetent, rhs: ResolvedDetent) -> Bool {
    lhs.height < rhs.height
  }

  static func ==(lhs: ResolvedDetent, rhs: ResolvedDetent) -> Bool {
    switch (lhs.identifier, rhs.identifier) {
    case (.dismiss, .dismiss): true
    case (.userDefined(let lhsIdentifier), .userDefined(let rhsIdentifier)):
      lhsIdentifier == rhsIdentifier
    case (.userDefined, .dismiss), (.dismiss, .userDefined):
      false
    }
  }
}
