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
    guard let email = emailTextField.text, let password = passwordTextField.text else { return }
    NetworkManager.shared.login(email: email, password: password) { boolResult in
      switch boolResult {
      case let .success(isSuccess):
        if isSuccess {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
          DispatchQueue.main.async {
            self.present(viewController, animated: true, completion: nil)
          }
        }
      default:
        return
      }
    }
  }

  @IBAction func createAccountButtonPressed(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let signupViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController")
    present(signupViewController, animated: true, completion: nil)
  }
}

