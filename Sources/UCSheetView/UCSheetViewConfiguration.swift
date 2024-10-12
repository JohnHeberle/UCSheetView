//
//  UCSheetViewConfiguration.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import os
import UIKit

extension UCSheetView {
  public struct Configuration {

    // MARK: Lifecycle

    #if DEBUG
    @_transparent
    init(
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
      var issueReporter: any IssueReportingProtocol = IssueReporter()
      sanitizeConfiguration(withIssueReporter: &issueReporter)
      #endif
    }

    // MARK: Public

    public let detents: [SheetDetent]
    public let largestUnDimmedDetentIdentifier: SheetDetent.Identifier?
    public let maxDimmingAlpha: CGFloat
    public let backgroundColor: UIColor
    public let grabberColor: UIColor
    public let cornerRadius: CGFloat
    public let shadowColor: CGColor
    public let shadowOpacity: Float
    public let shadowRadius: CGFloat

    // MARK: Internal

    #if DEBUG
    @usableFromInline @_transparent
    func sanitizeConfiguration(withIssueReporter issueReporter: inout any IssueReportingProtocol) {
      if detents.isEmpty {
        reportIssue(on: &issueReporter, AlertMessages.invalidDetentsWarning)
      }
      if Set(detents.map { $0.identifier }).count != detents.count {
        reportIssue(on: &issueReporter, AlertMessages.identicalDetentIdentifiersWarning)
      }
      if !Set(detents.map { $0.identifier }).contains(.default) {
        reportIssue(on: &issueReporter, AlertMessages.invalidDefaultDetentWarning)
      }
      if
        let largestUnDimmedDetentIdentifier,
        !Set(detents.map { $0.identifier }).contains(largestUnDimmedDetentIdentifier)
      {
        reportIssue(on: &issueReporter, AlertMessages.invalidLargestUnDimmedDetentIdentifierWarning)
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
