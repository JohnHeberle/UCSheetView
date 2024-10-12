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
  
  mutating func reportIssue(_ message: String, _ logType: OSLogType, fileID: StaticString, filePath: StaticString, line: UInt, column: UInt) {
    reportedIssues.insert(message)
  }
}

