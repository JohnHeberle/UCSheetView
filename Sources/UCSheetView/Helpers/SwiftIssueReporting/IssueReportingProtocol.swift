//
//  IssueReportingProtocol.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

#if DEBUG
import os
import Foundation

@usableFromInline
protocol IssueReportingProtocol {
  mutating func reportIssue(_ message: String, _ logType: OSLogType, fileID: StaticString, filePath: StaticString, line: UInt, column: UInt)
}
#endif
