//
//  Entry.swift
//  Vybes
//
//  Created by Willie Johnson on 3/19/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

struct Entry: Codable {
  /// The id of the entry
  var id: Int?
  /// The date the entry was entered.
  var date: String
  /// The text that was entered by the user.
  var body: String

  init(date: String, body: String) {
    self.date = date
    self.body = body
  }

  init(entry: Entry, body: String) {
    self = entry
    self.body = body
  }
}
