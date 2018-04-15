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
  /// The entry that is modified by the view controller
  var entry: Entry?

  /// Initializes the view controller with the Entry to be edited.
  init(entry: Entry) {
    super.init(nibName: nil, bundle: nil)
    self.entry = entry
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
