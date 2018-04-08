//
//  Entry.swift
//  Vybes
//
//  Created by Willie Johnson on 3/19/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

struct Entry: Codable {
  /// The date the entry was entered.
  var date: String
  /// The text that was entered by the user.
  var body: String
}
