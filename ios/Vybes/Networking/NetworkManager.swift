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
  
  /**
   Sends an HTTP request for User resource.

   Parameters:
   - type: The Codable that will be used to decode the json data received
   - resource: A Resource object used to construct the HTTP request.
   - completion: The completion handler used to access the data in the response.
   */
  func request<T: Codable>(_ type: T.Type, from resource: Resource, completion: @escaping AnyResult) {
    let urlRequest = getURLRequest(forResource: resource)
    urlSession.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        return completion(.failure(error))
      }

      guard let data = data else {
        return completion(.failure(ResourceError.noData))
      }

      if let result = try? JSONDecoder().decode(type, from: data) {
        return completion(.success(result))
      }

      return completion(.failure(ResourceError.couldNotParse))
      }.resume()
  }
}

// MARK: - Helper methods.
private extension NetworkManager {
  /**
   Constructs an HTTP request using the given resource object.

   - Parameters:
   - resource: Used to construct the request.
   - id: An optional used to construct the HTTP request params.

   - Returns: An URLRequest used to interact with the Resource of interest.
   */
  func getURLRequest(forResource resource: Resource) -> URLRequest {
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
