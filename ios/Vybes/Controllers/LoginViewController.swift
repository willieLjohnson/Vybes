//
//  LoginViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

/// Handles user signup and login
class LoginViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addTapToDismissKeyboardGesture()
    emailTextField.addDoneButtonOnKeyboard()
    passwordTextField.addDoneButtonOnKeyboard()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func loginButtonPressed(_ sender: UIButton) {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController")
    present(viewController, animated: true, completion: nil)
  }
}
