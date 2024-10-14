//
//  AlertMessages.swift
//  UCSheetView
//
//  Created by John Heberle on 10/8/24.
//

import Foundation

@usableFromInline
struct AlertMessages {

  // MARK: Public

  public static let invalidDetentsWarning = """
    UCSheetView Warning:

    `detents` passed to UCSheetView.Configuration is empty

    Default detents: ([.fractional(identifier: .default, divisor: 4), .fractional(identifier: .medium, divisor: 2)]) will be used. Specify the desired detents in the configuration passed to UCSheetView to achieve the expected functionality.
    """

  public static let identicalDetentIdentifiersWarning = """
    UCSheetView Warning:

    `detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier

    Enure the specified detents in the configuration passed to UCSheetView do not contain identical identifiers.
    """

  public static let invalidDefaultDetentWarning = """
    UCSheetView Warning:

    `detents` passed to UCSheetView.Configuration does not contain a default detent.

    Enure one of the specified detents in the configuration passed to UCSheetView contains the identifier `.default`.
    """

  public static let invalidLargestUnDimmedDetentIdentifierWarning = """
    UCSheetView Warning:

    `largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration

    Enure the `largestUnDimmedDetentIdentifier` is an identifier contained in the `detents` passed to the configuration.
    """

  // MARK: Internal

  static func invalidRequiredInit(on failedInitObject: AnyObject) -> String {
    let failedInitObjectTypeString = String(describing: failedInitObject)
    return "required init(coder:) has not been implemented on type \(failedInitObjectTypeString)"
  }

}
