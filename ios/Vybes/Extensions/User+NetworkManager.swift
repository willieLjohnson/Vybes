//
//  User+NetworkManager.swift
//  Vybes
//
//  Created by Willie Johnson on 3/28/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

extension NetworkManager {
  /// Sends a get requst to the server for retrieve user with given email and password.
  ///
  /// - Parameters:
  ///     - email: The unique email associated with this account.
  ///     - password: The password to access the account.
  func requestUser(_ resource: UserResource, completion: @escaping UserResult) {
    // Handle request
    NetworkManager.shared.request(User.self, from: resource) { anyResult in
      switch anyResult {
      case let .success(user):
        guard let user = user as? User else { return }
        completion(Result<User>.success(user))
      case let .failure(error):
        completion(Result<User>.failure(error))
      }
    }
  }

  func updateCurrentUser() {
    if user == nil {
      if let email = UserDefaults.standard.string(forKey: "email"),
        let password = UserDefaults.standard.string(forKey: "password") {
        login(email: email, password: password, completion: nil)
      }
    }
  }

  func login(email: String, password: String, completion: BoolResult?) {
    // Setup resource for user login
    let resource = UserResource.login(email: email, password: password)
    requestUser(resource) { userResult in
      let isSuccess = self.handle(userResult: userResult)
      if isSuccess {
        // Save user info
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
      }
      guard let completion = completion else { return }
      completion(Result<Bool>.success(isSuccess))
    }
  }

  func signup(name: String, email: String, password: String, completion: BoolResult?) {
    // Setup resource for user signup
    let resource = UserResource.signup(name: name, email: email, password: password)
    requestUser(resource) { userResult in
      let isSuccess = self.handle(userResult: userResult)
      if isSuccess {
        // Save user info
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
      }
      guard let completion = completion else { return }
      completion(Result<Bool>.success(true))
    }
  }

  func handle(userResult: Result<User>) -> Bool {
    switch userResult {
    case let .success(user):
      NetworkManager.shared.user = user
      return true
    case let .failure(error):
      dump(error)
      return false
    }
  }
}
