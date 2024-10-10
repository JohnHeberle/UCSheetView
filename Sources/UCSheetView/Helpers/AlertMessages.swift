//
//  AlertMessages.swift
//  UCSheetView
//
//  Created by John Heberle on 10/8/24.
//

import Foundation

struct AlertMessages {
  static func invalidRequiredInit(on failedInitObject: AnyObject) -> String {
    let failedInitObjectTypeString = String(describing: failedInitObject)
    return "required init(coder:) has not been implemented on type \(failedInitObjectTypeString)"
  }
}
