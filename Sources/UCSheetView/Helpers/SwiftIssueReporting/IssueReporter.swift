//
//  IssueReporter.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

#if DEBUG
import os
import Foundation
import SwiftUI

@usableFromInline
struct IssueReporter: IssueReportingProtocol {
  @UncheckedSendable @_transparent @usableFromInline var dso: UnsafeRawPointer

  init(dso: UnsafeRawPointer) {
    self.dso = dso
  }

  @usableFromInline init() {
    let count = _dyld_image_count()
    for i in 0..<count {
      if let name = _dyld_get_image_name(i) {
        let swiftString = String(cString: name)
        if swiftString.hasSuffix("/SwiftUI") {
          if let header = _dyld_get_image_header(i) {
            self.init(dso: UnsafeRawPointer(header))
            return
          }
        }
      }
    }
    self.init(dso: #dsohandle)
  }

  @_transparent
  public mutating func reportIssue(
    _ message: String,
    _ logType: OSLogType,
    fileID: StaticString,
    filePath: StaticString,
    line: UInt,
    column: UInt
  ) {
    let moduleName = String(
      Substring("\(fileID)".utf8.prefix(while: { $0 != UTF8.CodeUnit(ascii: "/") }))
    )
    let message = message.isEmpty ? "Issue reported" : message
    let log = OSLog(subsystem: "com.apple.runtime-issues", category: moduleName)

    os_log(.fault, dso: dso, log: log, "%@", message)
  }
}
#endif
