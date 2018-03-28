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
    let resource = UserResource.signup(name: name, email: email, password: password)

    NetworkManager.shared.request(with: resource) { (result) in
      switch result {
      case let .success(user):
        NetworkManager.shared.user = user as? User

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")

        DispatchQueue.main.async {
          self.present(viewController, animated: true, completion: nil)
//          UserDefaults.standard.set(email, forKey: "email")
//          UserDefaults.standard.set(password, forKey: "password")
        }
      case let .failure(error):
        dump(error)
      }
    }
  }
}
