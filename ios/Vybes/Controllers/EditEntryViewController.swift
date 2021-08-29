//
//  EditEntryViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 4/15/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit
import Ink

/// Screen used to create and edit Entry cells.
class EditEntryViewController: UIViewController {
  /// Text view used to type the body of the entry.
  @IBOutlet weak var entryTextView: UITextView! {
    didSet {
      entryTextView.layer.cornerRadius = 10
      entryTextView.addDropShadow()
    }
  }
  @IBOutlet weak var entryDateLabel: UILabel!
  @IBOutlet weak var doneButton: UIButton!
  /// The entry that is modified by the view controller.
  var selectedEntry: Entry?
  /// The index of the selected entry.
  var selectedEntryIndex: Int?
  
  weak var delegate: JournalViewDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addTapToDismissKeyboardGesture()
    entryTextView.addDoneButtonOnKeyboard()
    entryDateLabel.text = Date().displayDate()
    
    guard let selectedEntry = selectedEntry else { return }
    entryTextView.text = selectedEntry.content
    entryDateLabel.text = selectedEntry.date.displayDate()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func doneButtonPressed(_ sender: Any) {
    doneButton.animateTap()
    guard let delegate = delegate else { return }
    guard let entryText = entryTextView.text, entryText.count > 1 else {
      dismiss(animated: true, completion: nil)
      return
    }
    if var selectedEntry = selectedEntry, let selectedEntryIndex = selectedEntryIndex {
      selectedEntry.content = entryText
      delegate.updateEntry(selectedEntry, index: selectedEntryIndex)
    } else {
      let newEntry = Entry(date: Date(), content: entryText)
      delegate.postEntry(newEntry)
      CloudManager.instance.addNewEntry(newEntry)
    }
    dismiss(animated: true, completion: nil)
  }
}
