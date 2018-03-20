//
//  EntryTableViewCell.swift
//  Vybes
//
//  Created by Willie Johnson on 3/20/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation
import UIKit

/// Displays the date and body of an Entry.
class EntryTableViewCell: UITableViewCell {
  /// The label that displays the entry's date
  @IBOutlet weak var dateLabel: UILabel!
  /// The label that displays the entry's date in a tableview
  @IBOutlet weak var bodyLabel: UILabel!
  /// The Entry who's data will be shown
  var entry: Entry? {
    didSet {
      guard let entry = entry else { return }
      /// Automatically update the labels when the cell's entry is set.
      dateLabel.text = "\(entry.date)"
      bodyLabel.text = entry.body
    }
  }
}