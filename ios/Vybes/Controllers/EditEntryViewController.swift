//
//  EditEntryViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 4/15/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

/// Screen used to create and edit Entry cells.
class EditEntryViewController: UIViewController {
  /// Text view used to type the body of the entry.
  @IBOutlet weak var entryTextView: UITextView! {
    didSet {
      entryTextView.layer.cornerRadius = 10
      guard let selectedEntry = selectedEntry else { return }
      entryTextView.text = selectedEntry.body
    }
  }
  /// The entry that is modified by the view controller.
  var selectedEntry: Entry?
  /// The index of the selected entry.
  var selectedEntryIndex: Int?
  
  weak var delegate: JournalViewDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addTapToDismissKeyboardGesture()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func doneButtonPressed(_ sender: Any) {
    guard let delegate = delegate else { return }
    guard let entryText = entryTextView.text else { return }

    if var selectedEntry = selectedEntry, let selectedEntryIndex = selectedEntryIndex {
      selectedEntry.body = entryText
      delegate.updateEntry(selectedEntry, index: selectedEntryIndex)
    } else {
      let date = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      let today = dateFormatter.string(from: date)
      let newEntry = Entry(date: today, body: entryText)
      delegate.postEntry(newEntry)
    }
    dismiss(animated: true, completion: nil)
  }
}
