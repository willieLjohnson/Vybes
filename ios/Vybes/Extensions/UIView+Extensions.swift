//
//  UIView+Extensions.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation
import UIKit

// MARK: Tap to dismiss keyboard gesture
extension UIView {
  /// Add the tap to dismiss gesture to the current view
  func addTapToDismissKeyboardGesture() {
    let tapToDismissGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
    addGestureRecognizer(tapToDismissGesture)
  }

  /// Adds a shadow beneath the view
  func addDropShadow() {
    layer.shadowColor = Style.shadowColor
    layer.shadowOpacity = 1
    layer.shadowRadius = 4
    layer.shadowOffset = CGSize(width: 0, height: 4)
    layer.masksToBounds = false
  }

  /// The animation used for all tapable views.
  func animateTap(duration: TimeInterval = 0.1) {
    UIView.animate(withDuration: duration, animations: {
      self.transform = .init(scaleX: 0.9, y: 0.9)
      self.layer.shadowOffset = CGSize(width: 0, height: 2)
      self.layer.shadowRadius = 2
    }) { _ in
      UIView.animate(withDuration: duration * 1.75, animations: {
        self.transform = .identity
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
      })
    }
  }

  /// The highlight animation used for all highlitable views.
  func animateHighlight(transform: CGAffineTransform, offset: CGFloat, duration: TimeInterval = 0.1) {
    UIView.animate(withDuration: duration) {
      self.transform = transform
      self.layer.shadowOffset = CGSize(width: 0, height: offset)
      self.layer.shadowRadius = offset
    }
  }

}
