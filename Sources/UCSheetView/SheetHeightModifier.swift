//
//  SheetHeightModifier.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import UIKit

struct SheetHeightModifier {

  // MARK: Lifecycle

  init(updatedHeight: CGFloat, velocity: CGFloat = 0, animate: Bool = true, state: State = .started) {
    self.updatedHeight = updatedHeight
    self.velocity = velocity
    self.animate = animate
    self.state = state
  }

  // MARK: Internal

  enum State {
    case started, finished, continued
  }

  var updatedHeight: CGFloat
  var velocity: CGFloat
  var animate: Bool
  var state: State

  static func getState(forPanGestureState panGestureState: UIPanGestureRecognizer.State) -> State? {
    switch panGestureState {
    case .ended, .cancelled, .failed:
      .finished
    case .began:
      .started
    case .changed:
      .continued
    default:
      nil
    }
  }

}
