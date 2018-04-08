//
//  Result.swift
//  Vybes
//
//  Created by Willie Johnson on 4/6/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

/// Handles the response of a resource request.
enum Result<T> {
  case success(T)
  case failure(Error)
}

typealias AnyResult = (Result<Any>) -> Void
typealias BoolResult = (Result<Bool>) -> Void
typealias UserResult = (Result<User>) -> Void
typealias EntriesResult = (Result<[Entry]>) -> Void
