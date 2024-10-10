//
//  SheetHeightModifierModel.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Foundation

final class SheetHeightModifierModel {

  // MARK: Lifecycle

  init(sheetDetentsModel: SheetDetentsModel, initialSheetHeight: CGFloat) {
    self.sheetDetentsModel = sheetDetentsModel
    sheetHeight = initialSheetHeight

    sheetHeightModifier = SheetHeightModifier(updatedHeight: initialSheetHeight)
    minDetentHeight = sheetDetentsModel.minDetent.height
    maxDetentHeight = sheetDetentsModel.maxDetent.height
  }

  // MARK: Internal

  func update(translation: CGFloat, velocity: CGFloat, state: SheetHeightModifier.State) -> SheetHeightModifier {
    let translation = translation * -1
    let translationDelta = translation - previousTranslation
    previousTranslation = translation
    let modifier = getTranslationDeltaModifier(translationDelta: translationDelta)
    
    sheetHeight += translationDelta * modifier
    sheetHeightModifier.updatedHeight = sheetHeight
    sheetHeightModifier.velocity = min(abs(velocity / 100), 10)
    sheetHeightModifier.state = state
    
    if sheetHeight > maxDetentHeight + maxPanBeyondDetentBounds || sheetHeight < minDetentHeight - maxPanBeyondDetentBounds {
      sheetHeightModifier.state = .finished
    }

    if sheetHeightModifier.state == .finished {
      let updatedDetent = sheetDetentsModel.getDetent(forHeight: sheetHeightModifier.updatedHeight)
      sheetHeightModifier.updatedHeight = sheetDetentsModel.getDetentHeight(forDetent: updatedDetent)
    }

    return sheetHeightModifier
  }

  // MARK: Private

  private var previousTranslation: CGFloat = 0
  private var maxPanBeyondDetentBounds: CGFloat = 24
  private var beyondDetentPanDecaySensitivity: CGFloat = 5

  private let sheetDetentsModel: SheetDetentsModel
  private var sheetHeightModifier: SheetHeightModifier

  private var sheetHeight: CGFloat
  private let minDetentHeight: CGFloat
  private let maxDetentHeight: CGFloat

  private func getTranslationDeltaModifier(translationDelta: CGFloat) -> CGFloat {
    let translatedSheetHeight = sheetHeight + translationDelta

    var modifier: CGFloat = 1
    if translatedSheetHeight < minDetentHeight {
      let beyondDetentOffset = abs(translatedSheetHeight - minDetentHeight)
      modifier = min(1, (maxPanBeyondDetentBounds / beyondDetentPanDecaySensitivity) / beyondDetentOffset)
    } else if translatedSheetHeight > maxDetentHeight {
      let beyondDetentOffset = abs(translatedSheetHeight - maxDetentHeight)
      modifier = min(1, (maxPanBeyondDetentBounds / beyondDetentPanDecaySensitivity) / beyondDetentOffset)
    }

    return modifier
  }

}
