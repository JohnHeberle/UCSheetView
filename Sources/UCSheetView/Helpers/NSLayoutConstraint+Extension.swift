//
//  NSLayoutConstraint+Extension.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import UIKit

extension NSLayoutConstraint {
  enum Anchor {
    case leading(toSafeArea: Bool = false, constant: CGFloat = 0)
    case top(toSafeArea: Bool = false, constant: CGFloat = 0)
    case trailing(toSafeArea: Bool = false, constant: CGFloat = 0)
    case bottom(toSafeArea: Bool = false, constant: CGFloat = 0)
    
    var toSafeArea: Bool {
      switch self {
      case .leading(let toSafeArea, _), .top(let toSafeArea, _), .trailing(let toSafeArea, _), .bottom(let toSafeArea, _):
          return toSafeArea
      }
    }
    
    var constant: CGFloat {
      switch self {
      case .leading(_, let constant), .top(_, let constant), .trailing(_, let constant), .bottom(_, let constant):
        return constant
      }
    }
    
    static var leading: Self { .leading() }
    static var top: Self { .top() }
    static var trailing: Self { .trailing() }
    static var bottom: Self { .bottom() }
    
    static var bounds: [Self] { [.leading, .top, .trailing, .bottom] }
  }

  static func attatchAnchors(of child: UIView, to parent: UIView, for anchors: [Anchor] = Anchor.bounds) {
    for anchor in anchors {
      switch anchor {
        case .leading(let toSafeArea, let constant):
          let parentAnchor = toSafeArea ? parent.safeAreaLayoutGuide.leadingAnchor : parent.leadingAnchor
          activate([child.leadingAnchor.constraint(equalTo: parentAnchor, constant: constant)])
        case .top(let toSafeArea, let constant):
          let parentAnchor = toSafeArea ? parent.safeAreaLayoutGuide.topAnchor : parent.topAnchor
          activate([child.topAnchor.constraint(equalTo: parentAnchor, constant: constant)])
        case .trailing(let toSafeArea, let constant):
          let parentAnchor = toSafeArea ? parent.safeAreaLayoutGuide.trailingAnchor : parent.trailingAnchor
          activate([child.trailingAnchor.constraint(equalTo: parentAnchor, constant: constant)])
        case .bottom(let toSafeArea, let constant):
          let parentAnchor = toSafeArea ? parent.safeAreaLayoutGuide.bottomAnchor : parent.bottomAnchor
          activate([child.bottomAnchor.constraint(equalTo: parentAnchor, constant: constant)])
      }
    }
  }

  func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = priority
    return self
  }
}
