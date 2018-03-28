//
//  NetworkManager.swift
//  Vybes
//
//  Created by Willie Johnson on 3/25/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

class NetworkManager {
  /// The URLSession to be used by the client.
  let urlSession = URLSession.shared
  /// The baseURL of the server.
  let baseURL = "https://vybes-api.herokuapp.com/"
  /// Shared instance of Client.
  static let shared = NetworkManager()
  /// The User that's currently logged into the app
  var user: User?
}

// MARK: - Requests
extension NetworkManager {
  /**
   Sends an HTTP request to the server.

   Parameters:
   - resource: A Resource object used to construct the HTTP request.
   - completion: The completion handler used to access the data in the response.
   */
  func request(with resource: Resource, completion: @escaping (Result<Any>) -> Void) {
    let urlRequest = getURLRequest(for: resource)
    urlSession.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        return completion(.failure(error))
      }

      guard let data = data else {
        return completion(.failure(ResourceError.noData))
      }

      if let result = try? JSONDecoder().decode(User.self, from: data) {
        print("Result: \(result)")
        return completion(.success(result))
      }

      return completion(.failure(ResourceError.couldNotParse))
      }.resume()
  }
}

// MARK: - Helper functions.
private extension NetworkManager {
  /**
   Constructs an HTTP request using the given resource object.

   - Parameters:
   - resource: Used to construct the request.
   - id: An optional used to construct the HTTP request params.

   - Returns: An URLRequest used to interact with the Resource of interest.
   */
  func getURLRequest(for resource: Resource, with email: String? = nil) -> URLRequest {
    let params = resource.getParams()
    let urlString = baseURL.appending("\(resource.getPath())?\(resource.stringFrom(params))")
    let fullURL = URL(string: urlString)!

    var request = URLRequest(url: fullURL)
    request.httpMethod = resource.getHTTPMethod().rawValue
    request.allHTTPHeaderFields = resource.getHeaders()
    request.httpBody = resource.getBody()
  
    return request
  }
}
