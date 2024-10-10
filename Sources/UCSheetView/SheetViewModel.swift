//
//  SheetViewModel.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Combine
import Foundation

final class SheetViewModel {

  // MARK: Lifecycle

  init(sheetConfiguration: UCSheetView.Configuration) {
    self.sheetConfiguration = sheetConfiguration

    initializeSheetHeight()
    initializeDimmingAlpha()
  }

  // MARK: Internal

  var containerHeight = CurrentValueSubject<CGFloat, Never>(0)
  var sheetHeight = CurrentValueSubject<CGFloat, Never>(0)
  var sheetHeightModifier = CurrentValueSubject<SheetHeightModifier?, Never>(nil)
  var dimmingAlpha = CurrentValueSubject<CGFloat, Never>(0)

  func updateSheetPan(translation: CGFloat, velocity: CGFloat, state: SheetHeightModifier.State, cancelPan: () -> Void) {
    if sheetHeightModifierModel == nil {
      sheetHeightModifierModel = SheetHeightModifierModel(
        sheetDetentsModel: sheetDetentsModel,
        initialSheetHeight: sheetHeight.value
      )
    }

    guard let sheetHeightModifierModel else { return }

    let updatedSheetHeightModifierModel = sheetHeightModifierModel.update(
      translation: translation,
      velocity: velocity,
      state: state
    )

    if updatedSheetHeightModifierModel.state == .finished {
      sheetDetentsModel.selectedDetent = sheetDetentsModel.getDetent(forHeight: updatedSheetHeightModifierModel.updatedHeight)
      cancelPan()
      self.sheetHeightModifierModel = nil
    }

    sheetHeightModifier.send(updatedSheetHeightModifierModel)
  }

  func setToDefaultDetent(animated: Bool = true) {
    let updatedSheetHeightModifier = SheetHeightModifier(
      updatedHeight: sheetDetentsModel.getDetentHeight(forDetent: .default), animate: animated, state: .finished
    )
    sheetHeightModifier.send(updatedSheetHeightModifier)
  }

  // MARK: Private

  private var sheetConfiguration: UCSheetView.Configuration
  private var sheetHeightModifierModel: SheetHeightModifierModel?
  private lazy var sheetDetentsModel = SheetDetentsModel(containerHeight: 0, sheetConfiguration: sheetConfiguration)

  private var subscriptions = Set<AnyCancellable>()

  private func initializeSheetHeight() {
    containerHeight.first(where: { $0 != 0 }).sink { [weak self] containerHeight in
      guard let self else { return }
      sheetDetentsModel = SheetDetentsModel(containerHeight: containerHeight, sheetConfiguration: sheetConfiguration)
      setToDefaultDetent(animated: false)
    }.store(in: &subscriptions)
  }

  private func initializeDimmingAlpha() {
    sheetHeight
      .removeDuplicates()
      .compactMap { [weak self] sheetHeight in
        guard
          let self,
          let (largestUndimmedHeight, smallestDimmedHeight) = sheetDetentsModel.dimmingDetentHeights,
          sheetHeight > largestUndimmedHeight
        else { return 0 }
        let percentageHeightChange = (sheetHeight - largestUndimmedHeight) / (smallestDimmedHeight - largestUndimmedHeight)
        let maxDimmingAlpha = sheetConfiguration.maxDimmingAlpha
        return min(percentageHeightChange * maxDimmingAlpha, maxDimmingAlpha)
      }.assign(to: \.value, on: dimmingAlpha)
      .store(in: &subscriptions)
  }

}
