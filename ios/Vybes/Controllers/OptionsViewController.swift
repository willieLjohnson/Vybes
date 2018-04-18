//
//  OptionsViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 4/17/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController: UIViewController {
  override func viewDidLoad() {
    
  }
  
  @IBAction func dismissedButtonPressed(_ sender: Any) {
    UIApplication.shared.statusBarStyle = .default
    dismiss(animated: true, completion: nil)
  }

  @IBAction func logoutButtonPressed(_ sender: Any) {
    /// Reset defaults.
    let defaults = UserDefaults.standard
    NetworkManager.shared.user = nil
    defaults.set(nil, forKey: "email")
    defaults.set(nil, forKey: "password")
    /// Go back to login screen.
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    UIApplication.shared.statusBarStyle = .default
    present(loginViewController, animated: true, completion: nil)
  }
}
