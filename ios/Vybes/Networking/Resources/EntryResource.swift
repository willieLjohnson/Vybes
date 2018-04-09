//
//  EntryResource.swift
//  Vybes
//
//  Created by Willie Johnson on 3/28/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

/**
 Used to construct the HTTP requests related to user entries

 - getAll: A GET request that gets all the entries of the given user
 - post: A POST request that creates a new user document in the database.
 - edit: A PATCH request that updates the user's information (email, password, etc.)
 - delete: A DELETE request that completely removes the user from the database.
 */
enum EntryResource: Resource {
  case getAll
  case post(entry: Entry)
  case edit(entry: Entry)
  case delete(entry: Entry)

  func getHTTPMethod() -> HTTPMethod {
    switch self {
    case .getAll:
      return .get
    case .post:
      return .post
    case .edit:
      return .patch
    case .delete:
      return .del
    }
  }

  func getHeaders() -> [String: String] {
    guard let user = NetworkManager.shared.user else { return[:]}
    return [
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer \(user.token)"
    ]
  }

  func getParams() -> [String: String] {
    return [:]
  }

  /// Joins the list of parameters into a single string using "&" as the seperator.
  func stringFrom(_ parameters: [String: String]) -> String {
    let parameterArray = parameters.map { key, value in
      return "\(key)=\(value)"
    }

    return parameterArray.joined(separator: "&")
  }

  /// Get the path to the resource's route.
  func getPath() -> String {
    return "entries"
  }

  /// Get the necessary data to send for the request.
  func getBody() -> Data? {
    switch self {
    case let .post(entry), let .delete(entry):
      return try? JSONEncoder().encode(entry)
    default:
      return nil
    }
  }
}
