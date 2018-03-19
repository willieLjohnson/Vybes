import UIKit

/// Main View of the app
class ViewController: UIViewController {
  /// Textfield for entry input.
  @IBOutlet weak var entryTextField: UITextField!
  /// TableView for displaying entries.
  @IBOutlet weak var entriesTableView: UITableView!
  /// Keep track of all JournalEntry's that user has created.
  var entries: [JournalEntry]!

  override func viewDidLoad() {
    super.viewDidLoad()
    entries = [JournalEntry]()
    entriesTableView.dataSource = self
  }

  @IBAction func submitButtonPressed(_ sender: Any) {
    guard let entryText = entryTextField.text else { return }
    let today = Date()
    let newEntry = JournalEntry(body: "\(today): \(entryText)", date: Date())
    entries.append(newEntry)
    entriesTableView.reloadData()
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") else { return UITableViewCell() }
    let entry = entries[indexPath.row]
    cell.textLabel?.text = entry.body
    return cell
  }
}
