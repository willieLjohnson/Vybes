//
//  Date+Extensions.swift
//  Vybes
//
//  Created by Willie Johnson on 4/17/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

extension Date {
  func formattedStringDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a, yyyy")
    return dateFormatter.string(from: self)
  }

  func formattedEntryDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: self)
  }
}
