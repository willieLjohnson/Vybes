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
  /// The date when the Entry was created.
  var created_at: String?
  /// The date formatted for use in app.
  var formattedStringDate: String {
    get {
      guard let createdAt = created_at else { return ""}
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
      guard let date = dateFormatter.date(from: createdAt) else { return ""}
      return date.formattedStringDate()
    }
  }

  init(date: String, body: String) {
    self.date = date
    self.body = body
  }

  init(entry: Entry, body: String) {
    self = entry
    self.body = body
  }
}
