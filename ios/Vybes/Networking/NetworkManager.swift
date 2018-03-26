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
  let baseURL = "http://localhost:3000/"
  /// Shared instance of Client.
  static let shared = NetworkManager()
  /// The User that's currently logged into the app
  var user: User?

  init() {
    print("init")
  }
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
    urlSession.dataTask(with: getURLRequest(for: resource)) { data, response, error in
      if let error = error {
        return completion(Result.failure(error))
      }

      guard let data = data else {
        return completion(Result.failure(ResourceError.noData))
      }
      print(response)

      if let result = try? JSONDecoder().decode(User.self, from: data) {
        return completion(Result.success(result))
      }

      return completion(Result.failure(ResourceError.couldNotParse))
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

    print("\(resource.getPath())?\(resource.stringFrom(params))")
    let fullURL = URL(string: baseURL.appending("\(resource.getPath())?\(resource.stringFrom(params))"))!

    var request = URLRequest(url: fullURL)
    request.httpMethod = resource.getHTTPMethod().rawValue
    request.allHTTPHeaderFields = resource.getHeaders()
    request.httpBody = resource.getBody()
    print(request.httpBody)

    return request
  }
}

/**

 */
enum Result<T> {
  case success(T)
  case failure(Error)
}

/**
 Error cases that will be handled by the Client.

 - couldNotParse: Error occurs when that data retrieved can't be converted into a swift model.
 - noData: Error occurs when there is no response data.
 */
enum ResourceError: Error {
  case couldNotParse
  case noData
}

