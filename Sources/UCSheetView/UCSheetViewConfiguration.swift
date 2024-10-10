//
//  UCSheetViewConfiguration.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import UIKit
#if DEBUG
import IssueReporting
#endif

extension UCSheetView {
  public struct Configuration {

    // MARK: Lifecycle

    @_transparent
    public init(
      detents: [SheetDetent],
      largestUnDimmedDetentIdentifier: SheetDetent.Identifier? = nil,
      maxDimmingAlpha: CGFloat = 0.35,
      backgroundColor: UIColor = .white,
      grabberColor: UIColor = .lightGray,
      cornerRadius: CGFloat = 12,
      shadowColor: CGColor = UIColor.black.cgColor,
      shadowOpacity: Float = 0.3,
      shadowRadius: CGFloat = 12
    ) {
      self.detents = detents
      self.largestUnDimmedDetentIdentifier = largestUnDimmedDetentIdentifier
      self.maxDimmingAlpha = maxDimmingAlpha
      self.backgroundColor = backgroundColor
      self.grabberColor = grabberColor
      self.cornerRadius = cornerRadius
      self.shadowColor = shadowColor
      self.shadowOpacity = shadowOpacity
      self.shadowRadius = shadowRadius
      
      #if DEBUG
      if detents.isEmpty {
        let invalidDetentsWarning = "`detents` passed to UCSheetView.Configuration is empty. Default detents will be used but can result in unexpected behavior."
        reportIssue(invalidDetentsWarning)
      }
      if Set(detents.map { $0.identifier } ).count != detents.count {
        let identicalDetentIdentifiersWarning = "`detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier. `detents` must use unique identifiers. Any detent identified by a previously used identifier will be ignored."
        reportIssue(identicalDetentIdentifiersWarning)
      }
      if !Set(detents.map { $0.identifier } ).contains(.default) {
        let invalidDefaultDetentWarning = "`detents` passed to UCSheetView.Configuration does not contain a default detent. The default detent will be set to the smallest detent in the `detents` array after resolving heights."
        reportIssue(invalidDefaultDetentWarning)
      }
      if
        let largestUnDimmedDetentIdentifier = largestUnDimmedDetentIdentifier,
        !Set(detents.map { $0.identifier } ).contains(largestUnDimmedDetentIdentifier) {
        let invalidLargestUnDimmedDetentIdentifierWarning = "`largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration. The specified `largestUnDimmedDetentIdentifier` will be ignored."
        reportIssue(invalidLargestUnDimmedDetentIdentifierWarning)
      }
      #endif
    }

    // MARK: Internal

    public let detents: [SheetDetent]
    public let largestUnDimmedDetentIdentifier: SheetDetent.Identifier?
    public let maxDimmingAlpha: CGFloat
    public let backgroundColor: UIColor
    public let grabberColor: UIColor
    public let cornerRadius: CGFloat
    public let shadowColor: CGColor
    public let shadowOpacity: Float
    public let shadowRadius: CGFloat
    
  }
}
