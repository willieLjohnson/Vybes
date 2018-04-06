//
//  User.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

/// The User model used to encode and decode user data
struct User: Codable {
  /// The name of the user used as a username.
  var name: String
  /// The email of the user used for login.
  var email: String
  /// The token used for user authentication.
  var token: String
}

// MARK: Networking
extension User {
  /// Returns the entries created by this user.
  func getEntries() -> [Entry] {
    var entries = [Entry]()
    let resource = EntryResource.getAll
    NetworkManager.shared.request(Entry.self, from: resource) { (result) in
      switch result {
      case let .success(retrievedEntries):
        entries = retrievedEntries as! [Entry]
        print(entries)
      case let .failure(error):
        dump(error)
      }
    }
    return entries
  }

  /// Sends network request to POST a new entry
  func post(entry: Entry) {
    let resource = EntryResource.post(entry: entry)
    NetworkManager.shared.request(Entry.self, from: resource) { (result) in
      switch result {
      case let .success(user): break
      case let .failure(error):
        dump(error)
      }
    }
  }
}
