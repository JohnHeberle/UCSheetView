//
//  UCSheetViewConfiguration.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import UIKit
import os

extension UCSheetView {
  public struct Configuration {
    
    // MARK: Lifecycle
    
    #if DEBUG
    @_transparent init(
      detents: [SheetDetent],
      largestUnDimmedDetentIdentifier: SheetDetent.Identifier? = nil,
      maxDimmingAlpha: CGFloat = 0.35,
      backgroundColor: UIColor = .white,
      grabberColor: UIColor = .lightGray,
      cornerRadius: CGFloat = 12,
      shadowColor: CGColor = UIColor.black.cgColor,
      shadowOpacity: Float = 0.3,
      shadowRadius: CGFloat = 12,
      issueReporter: inout any IssueReportingProtocol
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
      
      sanitizeConfiguration(withIssueReporter: &issueReporter)
    }
    #endif
    
    @_transparent public init(
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
      var issueReporter: any IssueReportingProtocol = IssueReporter()
      sanitizeConfiguration(withIssueReporter: &issueReporter)
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
    
    #if DEBUG
    @usableFromInline @_transparent
    func sanitizeConfiguration(withIssueReporter issueReporter: inout any IssueReportingProtocol) {
      if detents.isEmpty {
        let invalidDetentsWarning = "`detents` passed to UCSheetView.Configuration is empty. Default detents will be used but can result in unexpected behavior."
        // reportIssue(invalidDetentsWarning)
        reportIssue(on: &issueReporter, invalidDetentsWarning)
      }
      if Set(detents.map { $0.identifier } ).count != detents.count {
        let identicalDetentIdentifiersWarning = "`detents` passed to UCSheetView.Configuration contains multiple detents with the same identifier. `detents` must use unique identifiers. Any detent identified by a previously used identifier will be ignored."
        // reportIssue(identicalDetentIdentifiersWarning)
        reportIssue(on: &issueReporter, identicalDetentIdentifiersWarning)
      }
      if !Set(detents.map { $0.identifier } ).contains(.default) {
        let invalidDefaultDetentWarning = "`detents` passed to UCSheetView.Configuration does not contain a default detent. The default detent will be set to the smallest detent in the `detents` array after resolving heights."
        reportIssue(on: &issueReporter, invalidDefaultDetentWarning)
        // reportIssue(invalidDefaultDetentWarning)
      }
      if
        let largestUnDimmedDetentIdentifier = largestUnDimmedDetentIdentifier,
        !Set(detents.map { $0.identifier } ).contains(largestUnDimmedDetentIdentifier) {
        let invalidLargestUnDimmedDetentIdentifierWarning = "`largestUnDimmedDetentIdentifier` is not contained in the `detents` passed to UCSheetView.Configuration. The specified `largestUnDimmedDetentIdentifier` will be ignored."
        reportIssue(on: &issueReporter, invalidLargestUnDimmedDetentIdentifierWarning)
        // reportIssue(invalidLargestUnDimmedDetentIdentifierWarning)
      }
    }
    
    @usableFromInline @_transparent
    func reportIssue(
      on issueReporter: inout any IssueReportingProtocol,
      _ message: String,
      _ logType: OSLogType = .error,
      fileID: StaticString = #fileID,
      filePath: StaticString = #filePath,
      line: UInt = #line,
      column: UInt = #column
    ) {
      issueReporter.reportIssue(message, logType, fileID: fileID, filePath: filePath, line: line, column: column)
    }
    #endif
    
  }
}
