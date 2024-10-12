//
//  NSLayoutConstraintExtensionTests.swift
//  UCSheetView
//
//  Created by John Heberle on 10/9/24.
//

import XCTest
@testable import UCSheetView

class NSLayoutConstraintExtensionTests: XCTestCase {

  // MARK: Internal

  var parentView: UIView!
  var childView: UIView!

  @MainActor
  override func setUp() async throws {
    parentView = UIView()
    childView = UIView()
    parentView.addSubview(childView)
  }

  @MainActor
  func testNSLayoutConstraintExtension_ConstraintWithPriority() {
    var constraint = childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
    XCTAssertEqual(constraint.priority, .required)
    constraint = constraint.withPriority(.defaultHigh)
    XCTAssertEqual(constraint.priority, .defaultHigh)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachDefaultAnchors() {
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView)
    processAnchors(withExpectedAnchors: [.leading, .top, .trailing, .bottom])
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachSingleAnchor() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachMultipleAnchor() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading, .trailing]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachSingleAnchorWithConstant() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading(constant: 20)]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachMultipleAnchorsWithConstant() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading(constant: 20), .trailing(constant: 20)]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachSingleAnchorWithSafeArea() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading(toSafeArea: true)]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachMultipleAnchorsWithSafeArea() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading(toSafeArea: true), .trailing(toSafeArea: true)]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachSingleAnchorWithMultipleModifiers() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading(toSafeArea: true, constant: 20)]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachMultipleAnchorsWithMultipleModifiers() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [
      .leading(toSafeArea: true, constant: 20),
      .top(toSafeArea: true, constant: 20),
      .trailing(toSafeArea: true, constant: 20),
      .bottom(toSafeArea: true, constant: 20),
    ]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_EmptyAnchors() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = []
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachIdenticalAnchors() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [.leading, .leading]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  @MainActor
  func testNSLayoutConstraintExtension_AttachIdenticalAnchorsWithMultipleModifiers() {
    let expectedAnchors: [NSLayoutConstraint.Anchor] = [
      .leading(toSafeArea: false, constant: 20),
      .leading(toSafeArea: true, constant: 20),
    ]
    NSLayoutConstraint.attatchAnchors(of: childView, to: parentView, for: expectedAnchors)
    processAnchors(withExpectedAnchors: expectedAnchors)
  }

  // MARK: Private

  @MainActor
  private func processAnchors(withExpectedAnchors expectedAnchors: [NSLayoutConstraint.Anchor]) {
    let expectedAnchorsContainsToSafeArea = expectedAnchors.reduce(false) { $0 || $1.toSafeArea }
    XCTAssertEqual(parentView.constraints.count, expectedAnchors.count + (expectedAnchorsContainsToSafeArea ? 4 : 0))

    var anchors = expectedAnchors
    let userDefinedConstraints = parentView.constraints.filter { $0.identifier == nil }
    for constraint in userDefinedConstraints {
      guard let anchorsIndex = getAnchorIndex(forConstraint: constraint, inAnchors: anchors, onView: parentView) else {
        XCTFail("Attribute: \(constraint.firstAttribute) not found in \(expectedAnchors)")
        return
      }

      XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
      XCTAssertEqual(constraint.constant, anchors[anchorsIndex].constant)
      XCTAssertTrue(constraint.isActive)

      if anchors[anchorsIndex].toSafeArea {
        switch constraint.firstAttribute {
        case .leading: XCTAssertEqual(childView.leadingAnchor, constraint.firstAnchor)
        case .top: XCTAssertEqual(childView.topAnchor, constraint.firstAnchor)
        case .trailing: XCTAssertEqual(childView.trailingAnchor, constraint.firstAnchor)
        case .bottom: XCTAssertEqual(childView.bottomAnchor, constraint.firstAnchor)
        default: XCTFail("Attribute: \(constraint.firstAttribute) not supported")
        }
        XCTAssertEqual(constraint.firstItem as? UIView, childView)
        XCTAssertTrue(constraint.secondItem is UILayoutGuide)
      } else {
        switch constraint.firstAttribute {
        case .leading:
          XCTAssertEqual(childView.leadingAnchor, constraint.firstAnchor)
          XCTAssertEqual(parentView.leadingAnchor, constraint.secondAnchor)

        case .top:
          XCTAssertEqual(childView.topAnchor, constraint.firstAnchor)
          XCTAssertEqual(parentView.topAnchor, constraint.secondAnchor)

        case .trailing:
          XCTAssertEqual(childView.trailingAnchor, constraint.firstAnchor)
          XCTAssertEqual(parentView.trailingAnchor, constraint.secondAnchor)

        case .bottom:
          XCTAssertEqual(childView.bottomAnchor, constraint.firstAnchor)
          XCTAssertEqual(parentView.bottomAnchor, constraint.secondAnchor)

        default:
          XCTFail("Attribute: \(constraint.firstAttribute) not supported")
        }
        XCTAssertEqual(constraint.firstItem as? UIView, childView)
        XCTAssertEqual(constraint.secondItem as? UIView, parentView)
      }

      anchors.remove(at: anchorsIndex)
    }

    XCTAssertEqual(anchors.count, 0)
  }

  @MainActor
  private func getAnchorIndex(
    forConstraint constraint: NSLayoutConstraint,
    inAnchors anchors: [NSLayoutConstraint.Anchor],
    onView _: UIView
  )
    -> Int?
  {
    anchors.firstIndex(where: { anchor in
      let isConstraintFirstItemValidForAnchor = anchor.toSafeArea
        ? constraint.secondItem is UILayoutGuide
        : constraint.secondItem as? UIView == parentView
      let isConstraintSecondItemValidForAnchor = attribute(forAnchor: anchor) == constraint.firstAttribute
      return isConstraintFirstItemValidForAnchor && isConstraintSecondItemValidForAnchor && anchor.constant == constraint.constant
    })
  }

  private func attribute(forAnchor anchor: NSLayoutConstraint.Anchor) -> NSLayoutConstraint.Attribute {
    switch anchor {
    case .leading: .leading
    case .top: .top
    case .trailing: .trailing
    case .bottom: .bottom
    }
  }
}
