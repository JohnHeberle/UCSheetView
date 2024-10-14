//
//  SheetDetentsModel.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Foundation

struct SheetDetentsModel {

  // MARK: Lifecycle

  init(containerHeight: CGFloat, sheetConfiguration: UCSheetView.Configuration) {
    self.sheetConfiguration = sheetConfiguration
    let detents = sheetConfiguration.detents.isEmpty || containerHeight == 0 ? defaultDetents : sheetConfiguration.detents

    var defaultDetentInit: ResolvedDetent?
    var resolvedDetentsInit: [ResolvedDetent] = []
    var detentIdentifiers = Set<ResolvedDetent.Identifier>()

    for detent in detents {
      if !detentIdentifiers.contains(detent.identifier.resolved()) {
        let resolvedDetent = ResolvedDetent(
          height: detent.resolver(containerHeight),
          identifier: detent.identifier.resolved()
        )
        if detent.identifier == .default {
          defaultDetentInit = resolvedDetent
        }
        detentIdentifiers.insert(detent.identifier.resolved())
        resolvedDetentsInit.append(resolvedDetent)
      }
    }
    resolvedDetentsInit.sort()

    if defaultDetentInit == nil {
      resolvedDetentsInit[0] = ResolvedDetent(
        height: resolvedDetentsInit.first!.height,
        identifier: SheetDetent.Identifier.default.resolved()
      )
      defaultDetentInit = resolvedDetentsInit.first!
    }

    if sheetConfiguration.isDismissable {
      resolvedDetentsInit.insert(ResolvedDetent(height: 0, identifier: .dismiss), at: 0)
    }

    resolvedDetents = resolvedDetentsInit
    selectedDetent = defaultDetentInit!.identifier
    minDetent = resolvedDetents.first!
    maxDetent = resolvedDetents.last!

    identifierToIndex = { [resolvedDetents] in
      var identifierToIndex: [ResolvedDetent.Identifier: Int] = [:]
      for (index, detent) in resolvedDetents.enumerated() {
        identifierToIndex[detent.identifier] = index
      }
      return identifierToIndex
    }()

    if
      let largestUnDimmedDetentIdentifier = sheetConfiguration.largestUnDimmedDetentIdentifier,
      detentIdentifiers.contains(largestUnDimmedDetentIdentifier.resolved()),
      let largestUnDimmedDetentIndex = identifierToIndex[largestUnDimmedDetentIdentifier.resolved()],
      largestUnDimmedDetentIndex < resolvedDetents.count - 1
    {
      let largestUnDimmedHeight = resolvedDetents[largestUnDimmedDetentIndex].height
      let smallestDimmedHeight = resolvedDetents[largestUnDimmedDetentIndex + 1].height
      dimmingHeights = DimmingHeights(largestUndimmedHeight: largestUnDimmedHeight, smallestDimmedHeight: smallestDimmedHeight)
    } else {
      dimmingHeights = nil
    }
  }

  // MARK: Internal

  struct DimmingHeights: Equatable {
    let largestUndimmedHeight: CGFloat
    let smallestDimmedHeight: CGFloat
  }

  var selectedDetent: ResolvedDetent.Identifier
  let minDetent: ResolvedDetent
  let maxDetent: ResolvedDetent
  let dimmingHeights: DimmingHeights?

  func getDetent(
    forHeight height: CGFloat,
    inDirection direction: SheetHeightModifier.Direction
  )
    -> ResolvedDetent.Identifier
  {
    let selectedDetent = resolvedDetents[identifierToIndex[selectedDetent]!]
    if isHeightInDetentBounds(height: height, detent: selectedDetent) {
      return selectedDetent.identifier
    }

    switch direction {
    case .up:
      switch sheetConfiguration.origin {
      case .bottom:
        return getNextSmallestDetent(forHeight: height, inDirection: direction)
      case .top:
        return getNextLargestDetent(forHeight: height, inDirection: direction)
      }

    case .down:
      switch sheetConfiguration.origin {
      case .bottom:
        return getNextLargestDetent(forHeight: height, inDirection: direction)
      case .top:
        return getNextSmallestDetent(forHeight: height, inDirection: direction)
      }
    }
  }

  func getNextSmallestDetent(
    forHeight height: CGFloat,
    inDirection _: SheetHeightModifier.Direction
  )
    -> ResolvedDetent.Identifier
  {
    for detent in resolvedDetents {
      if isHeightInDetentBounds(height: height, detent: detent) || height < detent.height {
        return detent.identifier
      }
    }
    return maxDetent.identifier
  }

  func getNextLargestDetent(
    forHeight height: CGFloat,
    inDirection _: SheetHeightModifier.Direction
  )
    -> ResolvedDetent.Identifier
  {
    for detent in resolvedDetents.reversed() {
      if isHeightInDetentBounds(height: height, detent: detent) || height > detent.height {
        return detent.identifier
      }
    }
    return minDetent.identifier
  }

  func getDetentHeight(forDetent identifier: ResolvedDetent.Identifier) -> CGFloat {
    resolvedDetents[identifierToIndex[identifier]!].height
  }

  // MARK: Private

  private let resolvedDetents: [ResolvedDetent]
  private let identifierToIndex: [ResolvedDetent.Identifier: Int]
  private let sheetConfiguration: UCSheetView.Configuration

  private var detentBoundsOffset: CGFloat = 24

  private var defaultDetents: [SheetDetent] = [
    .fractional(identifier: .default, divisor: 4),
    .fractional(identifier: .medium, divisor: 2),
  ]

  private func isHeightInDetentBounds(height: CGFloat, detent: ResolvedDetent) -> Bool {
    height > detent.height - detentBoundsOffset && height < detent.height + detentBoundsOffset
  }
}
