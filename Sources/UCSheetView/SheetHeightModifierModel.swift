//
//  SheetHeightModifierModel.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Foundation

final class SheetHeightModifierModel {

  // MARK: Lifecycle

  init(sheetConfiguration: UCSheetView.Configuration, sheetDetentsModel: SheetDetentsModel, initialSheetHeight: CGFloat) {
    self.sheetConfiguration = sheetConfiguration
    self.sheetDetentsModel = sheetDetentsModel
    sheetHeight = initialSheetHeight
    sheetHeightModifier = SheetHeightModifier(updatedHeight: initialSheetHeight)
  }

  // MARK: Internal

  func update(translation: CGFloat, velocity: CGFloat, state: SheetHeightModifier.State) -> SheetHeightModifier {
    sheetHeightModifier.direction = velocity > 0 ? .down : .up

    let translation = translation * (sheetConfiguration.origin == .bottom ? -1 : 1)
    let translationDelta = translation - previousTranslation
    previousTranslation = translation
    let modifier = getTranslationDeltaModifier(translationDelta: translationDelta)

    sheetHeight += translationDelta * modifier
    sheetHeightModifier.updatedHeight = sheetHeight
    sheetHeightModifier.velocity = min(abs(velocity / 100), 10)
    sheetHeightModifier.state = state

    if
      sheetHeight > sheetDetentsModel.maxDetent.height + maxPanBeyondDetentBounds || sheetHeight < sheetDetentsModel.minDetent
        .height - maxPanBeyondDetentBounds
    {
      sheetHeightModifier.state = .finished
    }

    if sheetHeightModifier.state == .finished {
      let updatedDetent = sheetDetentsModel.getDetent(
        forHeight: sheetHeightModifier.updatedHeight,
        inDirection: sheetHeightModifier.direction
      )
      sheetHeightModifier.animate = true
      sheetHeightModifier.updatedHeight = sheetDetentsModel.getDetentHeight(forDetent: updatedDetent)
    }

    return sheetHeightModifier
  }

  // MARK: Private

  private var previousTranslation: CGFloat = 0
  private var maxPanBeyondDetentBounds: CGFloat = 24
  private var beyondDetentPanDecaySensitivity: CGFloat = 5

  private let sheetConfiguration: UCSheetView.Configuration
  private let sheetDetentsModel: SheetDetentsModel
  private var sheetHeightModifier: SheetHeightModifier
  private var sheetHeight: CGFloat

  private func getTranslationDeltaModifier(translationDelta: CGFloat) -> CGFloat {
    let translatedSheetHeight = sheetHeight + translationDelta

    var modifier: CGFloat = 1
    if translatedSheetHeight < sheetDetentsModel.minDetent.height {
      let beyondDetentOffset = abs(translatedSheetHeight - sheetDetentsModel.minDetent.height)
      modifier = min(1, (maxPanBeyondDetentBounds / beyondDetentPanDecaySensitivity) / beyondDetentOffset)
    } else if translatedSheetHeight > sheetDetentsModel.maxDetent.height {
      let beyondDetentOffset = abs(translatedSheetHeight - sheetDetentsModel.maxDetent.height)
      modifier = min(1, (maxPanBeyondDetentBounds / beyondDetentPanDecaySensitivity) / beyondDetentOffset)
    }

    return modifier
  }
}
