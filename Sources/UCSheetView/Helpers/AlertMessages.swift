//
//  AlertMessages.swift
//  UCSheetView
//
//  Created by John Heberle on 10/8/24.
//

import Foundation

@usableFromInline
struct AlertMessages {
  static func invalidRequiredInit(on failedInitObject: AnyObject) -> String {
    let failedInitObjectTypeString = String(describing: failedInitObject)
    return "required init(coder:) has not been implemented on type \(failedInitObjectTypeString)"
  }

  public static let invalidDetentsWarning =
    "`detents` passed to UCSheetView.Configuration is empty. Default detents will be used but can result in unexpected behavior."

  public static let identicalDetentIdentifiersWarning =
    "`detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier. `detents` must use unique identifiers. Any detent identified by a previously used identifier will be ignored."

  public static let invalidDefaultDetentWarning =
    "`detents` passed to UCSheetView.Configuration does not contain a default detent. The default detent will be set to the smallest detent in the `detents` array after resolving heights."

  public static let invalidLargestUnDimmedDetentIdentifierWarning =
    "`largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration. The specified `largestUnDimmedDetentIdentifier` will be ignored."
}
