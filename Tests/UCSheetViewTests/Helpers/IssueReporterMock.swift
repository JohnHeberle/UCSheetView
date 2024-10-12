//
//  IssueReporterMock.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

import os
@testable import UCSheetView

struct IssueReporterMock: IssueReportingProtocol {
  private(set) var reportedIssues = Set<String>()

  mutating func reportIssue(
    _ message: String,
    _: OSLogType,
    fileID _: StaticString,
    filePath _: StaticString,
    line _: UInt,
    column _: UInt
  ) {
    reportedIssues.insert(message)
  }
}
