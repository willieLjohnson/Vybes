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
  /// The height of the cell
  static let HEIGHT: CGFloat = 59.0
  /// Where the bodyLabel wraps text
  var bodyLabelMaxWidth: CGFloat!
  /// The label that displays the entry's date
  @IBOutlet weak var dateLabel: UILabel!
  /// The label that displays the entry's date in a tableview
  @IBOutlet weak var bodyLabel: UILabel!
  /// The Entry who's data will be shown
  var entry: Entry? {
    didSet {
      guard let entry = entry else { return }
      /// Automatically update the labels when the cell's entry is sets
      dateLabel.text = entry.date.displayDate()
      bodyLabel.preferredMaxLayoutWidth = bodyLabel.frame.width
      bodyLabel.text = entry.content
    }
  }
  
  @IBOutlet weak var innerView: UIView! {
    didSet {
      clipsToBounds = false
      selectionStyle = .none
      innerView.layer.cornerRadius = 10
      innerView.addDropShadow()
    }
  }
}
