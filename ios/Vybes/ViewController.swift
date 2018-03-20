import UIKit

/// Main View of the app
class ViewController: UIViewController {
  /// Textfield for entry input.
  @IBOutlet weak var entryTextField: UITextField!
  /// TableView for displaying entries.
  @IBOutlet weak var entriesTableView: UITableView!
  /// Keep track of all JournalEntry's that user has created.
  var entries: [Entry]!

  override func viewDidLoad() {
    super.viewDidLoad()
    entries = [Entry]()
    entriesTableView.dataSource = self
    entriesTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    // Observe behavior of keyboard
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: view.window)
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: view.window)
    view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
  }

  override func viewWillDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }

  @IBAction func submitButtonPressed(_ sender: Any) {
    guard let entryText = entryTextField.text else { return }
    let newEntry = Entry(body: "\(entryText)", date: Date())
    entries.append(newEntry)
    entriesTableView.reloadData()
    scrollToBottom()
    entryTextField.text = ""
    view.endEditing(true)
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") as? EntryTableViewCell else {
      return UITableViewCell()
    }
    let entry = entries[indexPath.row]
    cell.entry = entry
    return cell
  }
}

// MARK: Keyboard notification
private extension ViewController {
  @objc func keyboardWillShow(notification: NSNotification) {
    let userInfo = notification.userInfo!

    let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size

    if view.frame.origin.y == 0 {
      UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.view.frame.origin.y -= keyboardSize.height
        let offset = self.entriesTableView.contentOffset
        self.entriesTableView.contentInset = UIEdgeInsetsMake(70 + keyboardSize.height, 0, 70 + keyboardSize.height, 0)
      })
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    let userInfo = notification.userInfo!
    let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
      self.view.frame.origin.y = 0
      self.entriesTableView.contentInset = UIEdgeInsetsMake(70, 0, 70, 0)
    })
  }
}

// MARK: Helper methods
private extension ViewController {
  /// Scroll the tableview to the bottom of the view.
  func scrollToBottom() {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: self.entries.count - 1, section: 0)
      self.entriesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
}
