//
//  SignupViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 3/26/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
  /// The new user's name
  @IBOutlet weak var nameTextField: UITextField!
  /// The new user's account email
  @IBOutlet weak var emailTextField: UITextField!
  /// The new user's account password
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func signupButtonPressed(_ sender: UIButton) {
    guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
    NetworkManager.shared.signup(name: name, email: email, password: password) { boolResult in
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
}
