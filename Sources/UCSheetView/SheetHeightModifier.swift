//
//  SheetHeightModifier.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import UIKit

struct SheetHeightModifier: Equatable {

  // MARK: Lifecycle

  init(
    updatedHeight: CGFloat,
    velocity: CGFloat = 0,
    animate: Bool = false,
    state: State = .started,
    direction: Direction = .up
  ) {
    self.updatedHeight = updatedHeight
    self.velocity = velocity
    self.animate = animate
    self.state = state
    self.direction = direction
  }

  // MARK: Internal

  enum State {
    case started, finished, continued
  }

  enum Direction {
    case down, up
  }

  var updatedHeight: CGFloat
  var velocity: CGFloat
  var animate: Bool
  var state: State
  var direction: Direction

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
