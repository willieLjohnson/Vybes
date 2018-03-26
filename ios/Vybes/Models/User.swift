//
//  User.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

struct User: Codable {
  /// The name of the user used as a username
  var name: String
  /// The email of the user used for login
  var email: String
  /// The password used to signin
  var password: String
}
