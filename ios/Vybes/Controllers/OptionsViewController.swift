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
  @IBOutlet weak var logoutButton: UIButton!
  weak var delegate: JournalViewDelegate?


  override func viewDidLoad() {
    if NetworkManager.shared.isLoggedIn {
      logoutButton.setTitle("Logout", for: .normal)
    } else {
      logoutButton.setTitle("Login", for: .normal)
    }
  }
  
  @IBAction func dismissedButtonPressed(_ sender: Any) {
    delegate?.updateData()
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
    present(loginViewController, animated: true, completion: nil)
  }

  @IBAction func icloudSwitchChanged(_ sender: UISwitch) {
    let defaults = UserDefaults.standard
    defaults.set(sender.isOn, forKey: "isCloudEnabled")
    
  }

}
