//
//  PanInfo.swift
//  UCSheetView
//
//  Created by John Heberle on 10/11/24.
//

import Foundation
@testable import UCSheetView

typealias PanValue = (CGFloat, CGFloat, SheetHeightModifier.State)
typealias PanInfo = (
  panValues: [PanValue],
  expectedSheetHeightModifierFromViewModel: [SheetHeightModifier],
  expectedSheetHeightModifierFromModifierModel: [SheetHeightModifier]
)

// MARK: - PanRecords

enum PanRecords {
  static let defaultPan: PanInfo = (
    panValues: [
      (0.0, -154.77748463179472, .started),
      (-18.5, -752.068389526577, .continued),
      (-18.5, -752.068389526577, .continued),
      (-84.5, -1403.1556878562433, .continued),
      (-137.0, -2966.9047474907484, .continued),
      (-199.0, -3324.3514825007114, .continued),
      (-262.5, -3786.6857854400646, .continued),
      (-301.0, -3557.2348717899604, .continued),
      (-315.0, -2054.0831357526463, .continued),
      (-315.0, -2054.0831357526463, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.5477748463179473, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 118.5, velocity: 7.52068389526577, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 118.5, velocity: 7.52068389526577, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 184.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 237.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 299.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 362.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 401.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 415.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.5477748463179473, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 118.5, velocity: 7.52068389526577, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 118.5, velocity: 7.52068389526577, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 184.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 237.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 299.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 362.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 401.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 415.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
    ]
  )

  static let topCancelledPan: PanInfo = (
    panValues: [
      (0.0, -242.59033282046806, .started),
      (-49.0, -1533.4006797962998, .continued),
      (-49.0, -1533.4006797962998, .continued),
      (-105.0, -3106.214199009732, .continued),
      (-171.5, -3447.0040698980756, .continued),
      (-245.0, -4057.327440967977, .continued),
      (-329.0, -4265.813866709318, .continued),
      (-463.0, -4811.540323403279, .continued),
      (-561.0, -6668.223183790344, .continued),
      (-656.0, -6018.466343243789, .continued),
      (-748.0, -5750.010551904729, .continued),
      (-832.0, -5411.10640586996, .continued),
      (-832.0, -5411.10640586996, .finished),
      (0.0, -147.85406489370578, .started),
      (-23.0, -853.8586867762114, .continued),
      (-23.0, -853.8586867762114, .continued),
      (-78.0, -1596.8212084934198, .continued),
      (-118.5, -2358.400177405014, .continued),
      (-163.5, -2489.199148028083, .continued),
      (-233.5, -2604.6116148572864, .continued),
      (-284.0, -2804.2549510961067, .continued),
      (-284.0, -2804.2549510961067, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 2.4259033282046807, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 149.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 149.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 205.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 271.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 345.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 429.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 439.20952380952383, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 451.85144855997174, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 461.58433866295974, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 469.82555262619667, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 477.3164185872043, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 1.4785406489370578, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 504.8, velocity: 8.538586867762113, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 504.8, velocity: 8.538586867762113, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 509.2147157190636, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 513.1250267243311, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 516.8411540480125, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 520.7102873372158, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 500.0, velocity: 1.4785406489370578, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 504.8, velocity: 8.538586867762113, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 504.8, velocity: 8.538586867762113, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 509.2147157190636, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 513.1250267243311, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 516.8411540480125, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 520.7102873372158, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .up),
    ]
  )

  static let bottomCancelledPan: PanInfo = (
    panValues: [
      (0.0, 129.80889744977668, .started),
      (17.5, 701.8477640760782, .continued),
      (17.5, 701.8477640760782, .continued),
      (52.0, 1133.2828295360798, .continued),
      (79.0, 1494.2593180108388, .continued),
      (109.5, 1587.7155362052767, .continued),
      (159.0, 1753.0655664301626, .continued),
      (159.0, 1753.0655664301626, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.2980889744977668, animate: false, state: .started, direction: .down),
      SheetHeightModifier(updatedHeight: 95.2, velocity: 7.018477640760782, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 95.2, velocity: 7.018477640760782, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 90.98625954198474, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 87.3876330635414, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 83.99185569377248, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 80.36482576464941, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 100.0, velocity: 10.0, animate: true, state: .finished, direction: .down),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.2980889744977668, animate: false, state: .started, direction: .down),
      SheetHeightModifier(updatedHeight: 95.2, velocity: 7.018477640760782, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 95.2, velocity: 7.018477640760782, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 90.98625954198474, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 87.3876330635414, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 83.99185569377248, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 80.36482576464941, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 100.0, velocity: 10.0, animate: true, state: .finished, direction: .down),
    ]
  )

  static let reversedMidPan: PanInfo = (
    panValues: [
      (0.0, -143.28105254375174, .started),
      (-21.0, -666.6522329180203, .continued),
      (-21.0, -666.6522329180203, .continued),
      (-40.0, -927.5787900316994, .continued),
      (-63.0, -1209.2581615998706, .continued),
      (-84.0, -1364.505234295267, .continued),
      (-118.5, -1192.2173920607881, .continued),
      (-137.0, -1493.261764808506, .continued),
      (-152.0, -1098.880266685404, .continued),
      (-165.0, -885.9030458133616, .continued),
      (-176.5, -765.5777703472056, .continued),
      (-184.5, -673.7742726829152, .continued),
      (-192.5, -496.28816496532704, .continued),
      (-199.5, -475.7824768024295, .continued),
      (-204.5, -385.8020964183741, .continued),
      (-207.5, -281.8081781167757, .continued),
      (-210.5, -173.02076297780226, .continued),
      (-210.5, -96.16909731461897, .continued),
      (-210.0, 3.1074960576927237, .continued),
      (-209.0, 22.904890285471147, .continued),
      (-203.5, 98.20232802233718, .continued),
      (-174.0, 497.30397247292876, .continued),
      (-115.5, 1646.3480209612626, .continued),
      (-65.0, 2839.9567944117634, .continued),
      (-18.0, 2994.6615400527053, .continued),
      (19.5, 2556.4733658529285, .continued),
      (37.0, 1372.814780590685, .continued),
      (41.0, 632.5594382371002, .continued),
      (41.0, 632.5594382371002, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.4328105254375174, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 121.0, velocity: 6.666522329180204, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 121.0, velocity: 6.666522329180204, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 140.0, velocity: 9.275787900316994, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 163.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 184.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 218.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 237.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 252.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 265.0, velocity: 8.859030458133615, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 276.5, velocity: 7.655777703472056, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 284.5, velocity: 6.737742726829152, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 292.5, velocity: 4.96288164965327, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 299.5, velocity: 4.757824768024295, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 304.5, velocity: 3.858020964183741, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 307.5, velocity: 2.818081781167757, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 310.5, velocity: 1.7302076297780227, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 310.5, velocity: 0.9616909731461897, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(
        updatedHeight: 310.0,
        velocity: 0.031074960576927237,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(
        updatedHeight: 309.0,
        velocity: 0.22904890285471147,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(
        updatedHeight: 303.5,
        velocity: 0.9820232802233718,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(updatedHeight: 274.0, velocity: 4.973039724729287, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 215.5, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 165.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 118.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 108.76923076923077, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 99.14808539478143, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(
        updatedHeight: 95.190884668423,
        velocity: 6.325594382371001,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(updatedHeight: 100.0, velocity: 6.325594382371001, animate: true, state: .finished, direction: .down),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.4328105254375174, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 121.0, velocity: 6.666522329180204, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 121.0, velocity: 6.666522329180204, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 140.0, velocity: 9.275787900316994, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 163.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 184.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 218.5, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 237.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 252.0, velocity: 10.0, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 265.0, velocity: 8.859030458133615, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 276.5, velocity: 7.655777703472056, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 284.5, velocity: 6.737742726829152, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 292.5, velocity: 4.96288164965327, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 299.5, velocity: 4.757824768024295, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 304.5, velocity: 3.858020964183741, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 307.5, velocity: 2.818081781167757, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 310.5, velocity: 1.7302076297780227, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 310.5, velocity: 0.9616909731461897, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(
        updatedHeight: 310.0,
        velocity: 0.031074960576927237,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(
        updatedHeight: 309.0,
        velocity: 0.22904890285471147,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(
        updatedHeight: 303.5,
        velocity: 0.9820232802233718,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(updatedHeight: 274.0, velocity: 4.973039724729287, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 215.5, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 165.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 118.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 108.76923076923077, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 99.14808539478143, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(
        updatedHeight: 95.190884668423,
        velocity: 6.325594382371001,
        animate: false,
        state: .continued,
        direction: .down
      ),
      SheetHeightModifier(updatedHeight: 100.0, velocity: 6.325594382371001, animate: true, state: .finished, direction: .down),
    ]
  )

  static let topDefaultPan: PanInfo = (
    panValues: [
      (0.0, 134.58779891392595, .started),
      (30.5, 778.355255942102, .continued),
      (30.5, 778.355255942102, .continued),
      (61.0, 1385.513057960662, .continued),
      (61.0, 1385.513057960662, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.3458779891392596, animate: false, state: .started, direction: .down),
      SheetHeightModifier(updatedHeight: 130.5, velocity: 7.78355255942102, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 130.5, velocity: 7.78355255942102, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 161.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .down),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 1.3458779891392596, animate: false, state: .started, direction: .down),
      SheetHeightModifier(updatedHeight: 130.5, velocity: 7.78355255942102, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 130.5, velocity: 7.78355255942102, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 161.0, velocity: 10.0, animate: false, state: .continued, direction: .down),
      SheetHeightModifier(updatedHeight: 500.0, velocity: 10.0, animate: true, state: .finished, direction: .down),
    ]
  )

  static let topDismissedPan: PanInfo = (
    panValues: [
      (0.0, -247.3881187251614, .started),
      (-7.0, -284.99143515602316, .continued),
      (-7.0, -284.99143515602316, .continued),
      (-12.5, -408.6290896481593, .continued),
      (-19.5, -308.6546445230455, .continued),
      (-23.5, -293.39894538203646, .continued),
      (-27.0, -239.20635554537955, .continued),
      (-31.0, -202.6789744085408, .continued),
      (-34.0, -170.19473632530907, .continued),
      (-38.0, -196.79706716950272, .continued),
      (-44.0, -260.36378286965845, .continued),
      (-58.5, -387.50956771172906, .continued),
      (-74.5, -651.8307670698124, .continued),
      (-74.5, -651.8307670698124, .finished),
    ],
    expectedSheetHeightModifierFromViewModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 2.473881187251614, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 93.0, velocity: 2.8499143515602317, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 93.0, velocity: 2.8499143515602317, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 87.5, velocity: 4.086290896481593, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 80.5, velocity: 3.086546445230455, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 76.5, velocity: 2.933989453820365, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 73.0, velocity: 2.3920635554537957, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 69.0, velocity: 2.026789744085408, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 66.0, velocity: 1.7019473632530906, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 62.0, velocity: 1.9679706716950272, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 56.0, velocity: 2.6036378286965847, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 41.5, velocity: 3.8750956771172906, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 25.5, velocity: 6.518307670698124, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 0.0, velocity: 6.518307670698124, animate: true, state: .finished, direction: .up),
    ],
    expectedSheetHeightModifierFromModifierModel: [
      SheetHeightModifier(updatedHeight: 100.0, velocity: 2.473881187251614, animate: false, state: .started, direction: .up),
      SheetHeightModifier(updatedHeight: 93.0, velocity: 2.8499143515602317, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 93.0, velocity: 2.8499143515602317, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 87.5, velocity: 4.086290896481593, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 80.5, velocity: 3.086546445230455, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 76.5, velocity: 2.933989453820365, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 73.0, velocity: 2.3920635554537957, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 69.0, velocity: 2.026789744085408, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 66.0, velocity: 1.7019473632530906, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 62.0, velocity: 1.9679706716950272, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 56.0, velocity: 2.6036378286965847, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 41.5, velocity: 3.8750956771172906, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 25.5, velocity: 6.518307670698124, animate: false, state: .continued, direction: .up),
      SheetHeightModifier(updatedHeight: 0.0, velocity: 6.518307670698124, animate: true, state: .finished, direction: .up),
    ]
  )
}
