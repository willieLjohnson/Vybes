import UIKit

/// Main View of the app
class ViewController: UIViewController {
  /// TableView for displaying entries.
  @IBOutlet weak var entriesTableView: UITableView!
  /// Keep track of all JournalEntry's that user has created.
  var entries = [Entry]() {
    didSet {
      DispatchQueue.main.async { 
        self.entriesTableView.reloadData()
      }
    }
  }
  /// Holds the most recent entry that was edited by the user.
  private var indexOfEditedEntry: Int?

  override func viewDidLoad() {
    super.viewDidLoad()
    entriesTableView.dataSource = self
    entriesTableView.delegate = self
    entriesTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    entriesTableView.estimatedRowHeight = 65
    entriesTableView.rowHeight = UITableViewAutomaticDimension

    getEntries()
  }

  func getEntries() {
    guard let user = NetworkManager.shared.user else {
      tryAgainAfterLogin()
      return
    }
    user.getEntries() { [unowned self] entries in
      self.entries = entries
    }
  }

  private func tryAgainAfterLogin() {
    if let email = UserDefaults.standard.string(forKey: "email"),
      let password = UserDefaults.standard.string(forKey: "password") {
      NetworkManager.shared.login(email: email, password: password) { [unowned self] _ in
        self.getEntries()
      }
    }
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
    cell.dateLabel.text = "12:30 pm"
    return cell
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableViewAutomaticDimension
//  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("🤥")
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let editCellAction = UITableViewRowAction(style: .normal, title: "edit") { [unowned self] (action, index) in
      let entry = self.entries[indexPath.row]
      self.indexOfEditedEntry = indexPath.row
    }

    let deleteCellAction = UITableViewRowAction(style: .destructive, title: "delete") { [unowned self] (action, index) in
      guard let user = NetworkManager.shared.user else { return }
      user.delete(entry: self.entries[indexPath.row])
      self.entries.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    return [deleteCellAction, editCellAction]
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

extension ViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
  }
}
