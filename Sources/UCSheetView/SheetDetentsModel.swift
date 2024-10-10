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
    var detentIdentifiers = Set<SheetDetent.Identifier>()

    for detent in detents {
      if !detentIdentifiers.contains(detent.identifier) {
        let resolvedDetent = ResolvedDetent(height: detent.resolver(containerHeight), identifier: detent.identifier)
        if detent.identifier == .default {
          defaultDetentInit = resolvedDetent
        }
        detentIdentifiers.insert(detent.identifier)
        resolvedDetentsInit.append(resolvedDetent)
      }
    }
    resolvedDetentsInit.sort()
    
    if defaultDetentInit == nil  {
      resolvedDetentsInit[0] = ResolvedDetent(height: resolvedDetentsInit.first!.height, identifier: .default)
      defaultDetentInit = resolvedDetentsInit.first!
    }
    
    resolvedDetents = resolvedDetentsInit
    selectedDetent = defaultDetentInit!.identifier
    minDetent = resolvedDetents.first!
    maxDetent = resolvedDetents.last!

    identifierToIndex = { [resolvedDetents] in
      var identifierToIndex: [SheetDetent.Identifier: Int] = [:]
      for (index, detent) in resolvedDetents.enumerated() {
        identifierToIndex[detent.identifier] = index
      }
      return identifierToIndex
    }()

    if
      let largestUnDimmedDetentIdentifier = sheetConfiguration.largestUnDimmedDetentIdentifier,
      detentIdentifiers.contains(largestUnDimmedDetentIdentifier),
      let largestUnDimmedDetentIndex = identifierToIndex[largestUnDimmedDetentIdentifier],
      largestUnDimmedDetentIndex < resolvedDetents.count - 1
    {
      let largestUnDimmedHeight = resolvedDetents[largestUnDimmedDetentIndex].height
      let smallestDimmedHeight = resolvedDetents[largestUnDimmedDetentIndex + 1].height
      dimmingDetentHeights = (largestUnDimmedHeight, smallestDimmedHeight)
    } else {
      dimmingDetentHeights = nil
    }
  }

  // MARK: Internal

  struct ResolvedDetent: Comparable, Equatable {
    let height: CGFloat
    let identifier: SheetDetent.Identifier

    static func <(lhs: ResolvedDetent, rhs: ResolvedDetent) -> Bool {
      lhs.height < rhs.height
    }
  }

  var selectedDetent: SheetDetent.Identifier
  let minDetent: ResolvedDetent
  let maxDetent: ResolvedDetent
  let dimmingDetentHeights: (largestUndimmedHeight: CGFloat, smallestDimmedHeight: CGFloat)?

  func getDetent(forHeight height: CGFloat) -> SheetDetent.Identifier {
    let selectedDetent = resolvedDetents[identifierToIndex[selectedDetent]!]
    if isHeightInDetentBounds(height: height, detent: selectedDetent) {
      return selectedDetent.identifier
    }

    if height < selectedDetent.height {
      for detent in resolvedDetents.reversed() {
        if isHeightInDetentBounds(height: height, detent: detent) || height > detent.height {
          return detent.identifier
        }
      }
      return minDetent.identifier
    } else {
      for detent in resolvedDetents {
        if isHeightInDetentBounds(height: height, detent: detent) || height < detent.height {
          return detent.identifier
        }
      }
      return maxDetent.identifier
    }
  }

  func getSmallestDetentGreaterThan(height: CGFloat) -> SheetDetent.Identifier {
    for detent in resolvedDetents {
      if getDetentHeight(forDetent: detent.identifier) > height {
        return detent.identifier
      }
    }
    return resolvedDetents.last!.identifier
  }

  func getDetentHeight(forDetent identifier: SheetDetent.Identifier) -> CGFloat {
    resolvedDetents[identifierToIndex[identifier]!].height
  }

  // MARK: Private

  private let resolvedDetents: [ResolvedDetent]
  private let identifierToIndex: [SheetDetent.Identifier: Int]
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
