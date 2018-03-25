//
//  UITextField+Extensions.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation
import UIKit

// MARK: Add done button on keyboard.
extension UITextField {
  /// Add done button to keyboard UIToolbar
  func addDoneButtonOnKeyboard() {
    let doneToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
  }

  @objc func doneButtonAction() {
    self.resignFirstResponder()
  }
}
