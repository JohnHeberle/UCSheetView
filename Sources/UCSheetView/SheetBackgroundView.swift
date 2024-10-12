//
//  SheetBackgroundView.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Combine
import UIKit

final class SheetBackgroundView: UIView {

  // MARK: Lifecycle

  required init?(coder _: NSCoder) { fatalError(AlertMessages.invalidRequiredInit(on: Self.self)) }

  init(sheetConfiguration: UCSheetView.Configuration) {
    super.init(frame: .zero)

    layer.masksToBounds = false
    layer.shadowOffset = .zero
    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    backgroundColor = sheetConfiguration.backgroundColor
    layer.cornerRadius = sheetConfiguration.cornerRadius
    layer.shadowColor = sheetConfiguration.shadowColor
    layer.shadowOpacity = sheetConfiguration.shadowOpacity
    layer.shadowRadius = sheetConfiguration.shadowRadius
    
    addSubview(contentView)
    NSLayoutConstraint.attatchAnchors(of: contentView, to: self)
  }

  // MARK: Internal

  var sheetHeight: CurrentValueSubject<CGFloat, Never>?

  override func layoutSubviews() {
    super.layoutSubviews()
    sheetHeight?.send(frame.height)
  }

  lazy var contentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.clipsToBounds = true
    return contentView
  }()
}
