//
//  UCSheetView.swift
//  UCSheetView
//
//  Created by John Heberle on 10/7/24.
//

import Combine
import UIKit

public final class UCSheetView: UIView {

  // MARK: Lifecycle

  required init?(coder _: NSCoder) { fatalError(AlertMessages.invalidRequiredInit(on: Self.self)) }

  public init(frame: CGRect = .zero, contentView: UIView, sheetConfiguration: Configuration) {
    viewModel = SheetViewModel(sheetConfiguration: sheetConfiguration)
    self.sheetConfiguration = sheetConfiguration

    super.init(frame: frame)

    setUpViews(with: contentView)
    setUpGestureRecognizers()
    bindToViewModel()
  }

  // MARK: Public

  public override func layoutSubviews() {
    viewModel.containerHeight.send(frame.height)
  }

  public override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
    for subview in subviews {
      if !subview.isHidden, subview.isUserInteractionEnabled, subview.frame.contains(point) {
        return true
      }
    }
    return false
  }

  // MARK: Internal

  let viewModel: SheetViewModel

  // MARK: Private

  private let sheetConfiguration: Configuration
  private var subscriptions = Set<AnyCancellable>()

  private lazy var sheetHeightAnchor = sheetBackgroundView.heightAnchor.constraint(equalToConstant: 0).withPriority(
    .required,
    offset: -1
  )

  private var dimmableBackgroundView: UIView = {
    var dimmableBackgroundView = UIView()
    dimmableBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    dimmableBackgroundView.backgroundColor = .black
    dimmableBackgroundView.alpha = 0
    dimmableBackgroundView.isUserInteractionEnabled = false
    return dimmableBackgroundView
  }()

  private lazy var sheetBackgroundView: SheetBackgroundView = {
    let sheetBackgroundView = SheetBackgroundView(sheetConfiguration: sheetConfiguration)
    sheetBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    return sheetBackgroundView
  }()

  private lazy var grabberView: UIView = {
    var grabberView = UIView()
    grabberView.translatesAutoresizingMaskIntoConstraints = false
    let grabberSize = CGSize(width: 36, height: 5)
    grabberView.layer.cornerRadius = grabberSize.height / 2
    grabberView.backgroundColor = sheetConfiguration.grabberColor
    grabberView.clipsToBounds = true
    grabberView.isUserInteractionEnabled = false
    NSLayoutConstraint.activate([
      grabberView.heightAnchor.constraint(equalToConstant: grabberSize.height),
      grabberView.widthAnchor.constraint(lessThanOrEqualToConstant: grabberSize.width),
      grabberView.widthAnchor.constraint(equalToConstant: CGFloat.greatestFiniteMagnitude).withPriority(.defaultLow),
    ])
    return grabberView
  }()

  private func setUpViews(with contentView: UIView) {
    for view in [dimmableBackgroundView, sheetBackgroundView] { addSubview(view) }
    NSLayoutConstraint.attatchAnchors(of: dimmableBackgroundView, to: self)
    NSLayoutConstraint.activate([sheetHeightAnchor])

    switch sheetConfiguration.origin {
    case .bottom:
      NSLayoutConstraint.attatchAnchors(of: sheetBackgroundView, to: self, for: [.leading, .trailing, .bottom])
    case .top:
      NSLayoutConstraint.attatchAnchors(of: sheetBackgroundView, to: self, for: [.leading, .trailing, .top])
    }

    contentView.translatesAutoresizingMaskIntoConstraints = false
    for view in [grabberView, contentView] { sheetBackgroundView.contentView.addSubview(view) }
    let resolvedContentView = sheetBackgroundView.contentView

    switch sheetConfiguration.origin {
    case .bottom:
      NSLayoutConstraint.activate([
        grabberView.topAnchor.constraint(equalTo: resolvedContentView.topAnchor, constant: 5).withPriority(.required, offset: -1),
        contentView.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 12).withPriority(.required, offset: -1),
        contentView.bottomAnchor.constraint(equalTo: resolvedContentView.bottomAnchor).withPriority(.required, offset: -2),
      ])

    case .top:
      NSLayoutConstraint.activate([
        grabberView.bottomAnchor.constraint(equalTo: resolvedContentView.bottomAnchor, constant: -5).withPriority(
          .required,
          offset: -1
        ),
        contentView.bottomAnchor.constraint(equalTo: grabberView.topAnchor, constant: -12).withPriority(.required, offset: -1),
        contentView.topAnchor.constraint(equalTo: resolvedContentView.topAnchor).withPriority(.required, offset: -2),
      ])
    }
    NSLayoutConstraint.activate([
      grabberView.centerXAnchor.constraint(equalTo: resolvedContentView.centerXAnchor).withPriority(.required, offset: -1),
    ])
    NSLayoutConstraint.attatchAnchors(of: contentView, to: resolvedContentView, for: [.leading, .trailing])
  }

  private func setUpGestureRecognizers() {
    let sheetPanGestureRecognizer =
      UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan(_:)))
    sheetBackgroundView.addGestureRecognizer(sheetPanGestureRecognizer)

    let dimmedViewTapGestureRecognizer =
      UITapGestureRecognizer(target: self, action: #selector(handleDimmedViewTap(_:)))
    dimmedViewTapGestureRecognizer.numberOfTapsRequired = 1
    dimmedViewTapGestureRecognizer.numberOfTouchesRequired = 1
    dimmableBackgroundView.addGestureRecognizer(dimmedViewTapGestureRecognizer)
  }

  private func bindToViewModel() {
    sheetBackgroundView.sheetHeight = viewModel.sheetHeight

    viewModel.dimmingAlpha.sink { [weak self] backgroundViewAlpha in
      guard let self else { return }
      dimmableBackgroundView.alpha = backgroundViewAlpha
      dimmableBackgroundView.isUserInteractionEnabled = backgroundViewAlpha != 0
    }.store(in: &subscriptions)

    viewModel.sheetHeightModifier.sink { [weak self] sheetHeightModifier in
      guard let self, let sheetHeightModifier else { return }
      sheetHeightAnchor.constant = sheetHeightModifier.updatedHeight

      if sheetHeightModifier.state == .started {
        layer.removeAllAnimations()
      }

      if sheetHeightModifier.state == .finished, sheetHeightModifier.animate {
        UIView.animate(
          withDuration: 0.5,
          delay: 0.0,
          usingSpringWithDamping: 0.95,
          initialSpringVelocity: sheetHeightModifier.velocity,
          options: [.curveEaseOut, .allowUserInteraction],
          animations: { [weak self] in
            guard let self else { return }
            layoutIfNeeded()
          },
          completion: { [weak self] _ in
            guard let self else { return }
            if sheetHeightModifier.updatedHeight == 0 {
              removeFromSuperview()
            }
          }
        )
      }
    }.store(in: &subscriptions)
  }

  @objc
  private func handleSheetPan(_ panGesture: UIPanGestureRecognizer) {
    guard let state = SheetHeightModifier.getState(forPanGestureState: panGesture.state) else { return }
    let translation = panGesture.translation(in: self).y
    let velocity = panGesture.velocity(in: self).y
    viewModel.updateSheetPan(translation: translation, velocity: velocity, state: state, cancelPan: {
      panGesture.state = .cancelled
    })
  }

  @objc
  private func handleDimmedViewTap(_: UITapGestureRecognizer) {
    viewModel.setToDefaultDetent()
  }
}
