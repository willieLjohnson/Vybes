import Foundation

/**
 HTTP methods used in this app.
 
 - get: An HTTP GET request.
 - post: An HTTP POST request.
 - patch: An HTTP PATCH request.
 - del: An HTTP DELETE request.
 */
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case patch = "PATCH"
  case del = "DELETE"
}

/**
 Used to construct the HTTP request for the User resource.
 
 - login: A GET request that checks to see if there is a matching user.
 - signup: A POST request that creates a new user document in the database.
 - update: A PATCH request that updates the user's information (email, password, etc.)
 - delete: A DELETE request that completely removes the user from the database.
 */
enum UserResource: Resource {
  case login(email: String, password: String)
  case signup(name: String, email: String, password: String)
  case update(email: String, password: String)
  case delete(email: String, password: String)

  func getHTTPMethod() -> HTTPMethod {
    switch self {
    case .login:
      return .get
    case .signup:
      return .post
    case .update:
      return .patch
    case .delete:
      return .del
    }
  }

  func getHeaders() -> [String: String] {
    return ["":""]
  }

  func getParams() -> [String: String] {
    switch self {
    case let .signup(name, email, password):
      return ["name": name, "email": email, "password": password]
    case let .login(email, password):
      return ["email": email, "password": password]
    default:
      return [:]
    }
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
    switch self {
    case .login:
      return "users/login"
    default:
      return "users"
    }
  }

  /// Get the necessary data to send for the request.
  func getBody() -> Data? {
    switch self {
    case let .signup(name, email, password):
      let user = [
        "name": name,
        "email": email,
        "password": password,
      ]
      return try? JSONEncoder().encode(user)
    default:
    return nil
    }
  }
}
