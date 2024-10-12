//
//  IssueReporter.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

/// ### Important
/// Never include IssueReporter in release builds
///
/// IssueReporter uses the functionality from swift-issue-reporting
/// github: https://github.com/pointfreeco/swift-issue-reporting
/// documentation: https://swiftpackageindex.com/pointfreeco/swift-issue-reporting/main/documentation/issuereporting/releasemode
///
/// The documentation for swift-issue-reporting states, "many of the techniques
/// employed by this package to allow for triggering test failures from app code are
/// not safe for release builds (or App Store submissions)". In UCSheetView, all calls
/// to IssueReporter are conntained in #if DEBUG #endif to ensure release safety.

#if DEBUG
import Foundation
import os
import SwiftUI

@propertyWrapper @usableFromInline
struct UncheckedSendable<Value>: @unchecked Sendable {
  @usableFromInline var wrappedValue: Value

  init(wrappedValue value: Value) {
    wrappedValue = value
  }
}

@usableFromInline
protocol IssueReportingProtocol {
  mutating func reportIssue(
    _ message: String,
    _ logType: OSLogType,
    fileID: StaticString,
    filePath: StaticString,
    line: UInt,
    column: UInt
  )
}

@usableFromInline
struct IssueReporter: IssueReportingProtocol {

  // MARK: Lifecycle

  init(dso: UnsafeRawPointer) {
    self.dso = dso
  }

  @usableFromInline
  init() {
    let count = _dyld_image_count()

    for i in 0 ..< count {
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

  // MARK: Public

  @_transparent
  public mutating func reportIssue(
    _ message: String,
    _: OSLogType,
    fileID: StaticString,
    filePath _: StaticString,
    line _: UInt,
    column _: UInt
  ) {
    let moduleName = String(
      Substring("\(fileID)".utf8.prefix(while: { $0 != UTF8.CodeUnit(ascii: "/") }))
    )
    let message = message.isEmpty ? "Issue reported" : message
    let log = OSLog(subsystem: "com.apple.runtime-issues", category: moduleName)

    os_log(.fault, dso: dso, log: log, "%@", message)
  }

  // MARK: Internal

  @UncheckedSendable @_transparent @usableFromInline var dso: UnsafeRawPointer

}
#endif
