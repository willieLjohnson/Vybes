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
}
