import UIKit

/// Delegate used to modify entries.
protocol JournalViewDelegate: class {
  /// Creates or updates an existing entry
  func postEntry(_ entry: Entry)
  func updateEntry(_ entry: Entry, index: Int)
  func updateData()
}

/// Main View of the app
class JournalViewController: UIViewController {
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
  /// Presents the meditateViewController.
  @IBOutlet weak var meditateBarButton: UIBarButtonItem!
  /// Presents the editEntrViewController.
  @IBOutlet weak var createEntryBarButton: UIBarButtonItem!
  /// Presents the optionsViewController.
  @IBOutlet weak var optionsBarButton: UIBarButtonItem!
  @IBOutlet weak var quoteTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    entriesTableView.dataSource = self
    entriesTableView.delegate = self
    entriesTableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0)
    entriesTableView.estimatedRowHeight = 65
    entriesTableView.rowHeight = UITableViewAutomaticDimension

    createEntryBarButton.action = #selector(createEntryButtonPressed)
    optionsBarButton.action = #selector(optionsButtonPressed)
    meditateBarButton.action = #selector(meditateButtonPressed)
    createEntryBarButton.target = self
    optionsBarButton.target = self
    meditateBarButton.target = self

    getEntries()
  }

  @objc func createEntryButtonPressed() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let editEntryViewController = storyboard.instantiateViewController(withIdentifier: "EditEntryViewController") as? EditEntryViewController else { return }
    editEntryViewController.modalPresentationStyle = .overFullScreen
    editEntryViewController.delegate = self
    present(editEntryViewController, animated: true) {
      UIApplication.shared.statusBarStyle = .lightContent
    }
  }

  @objc func optionsButtonPressed() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let optionsViewController = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as? OptionsViewController else { return }
    optionsViewController.modalPresentationStyle = .overFullScreen
    optionsViewController.delegate = self
    present(optionsViewController, animated: true) {
      UIApplication.shared.statusBarStyle = .lightContent
    }
  }

  @objc func meditateButtonPressed() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let meditateViewController = storyboard.instantiateViewController(withIdentifier: "MeditateViewController") as? MeditateViewController else { return }
    meditateViewController.modalPresentationStyle = .overFullScreen
    present(meditateViewController, animated: true) {
      UIApplication.shared.statusBarStyle = .lightContent
    }
  }

  func getEntries() {
    entries = CloudManager.instance.getEntries()
  }
}

// MARK: UITableViewDataSource
extension JournalViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") as? EntryTableViewCell else {
      return EntryTableViewCell()
    }
    let entry = entries[indexPath.row]
    cell.entry = entry
    return cell
  }
}

// MARK: JournalViewDelegate
extension JournalViewController: JournalViewDelegate {
  func postEntry(_ entry: Entry) {
    CloudManager.instance.addNewEntry(entry)
    entries.append(entry)
    scrollToBottom()
  }

  func updateEntry(_ entry: Entry, index: Int) {
    entries[index] = entry
    CloudManager.instance.updateEntry(entry)
  }

  func updateData() {
    getEntries()
  }
}

// MARK: UITableViewDelegate
extension JournalViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableViewAutomaticDimension
//  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? EntryTableViewCell else { return }
    cell.innerView.animateTap()
  
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let editEntryViewController = storyboard.instantiateViewController(withIdentifier: "EditEntryViewController") as? EditEntryViewController else { return }
    editEntryViewController.selectedEntry = cell.entry
    editEntryViewController.selectedEntryIndex = indexPath.row
    editEntryViewController.delegate = self
    present(editEntryViewController, animated: true, completion:  nil)
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.2) {
      if let cell = tableView.cellForRow(at: indexPath) as? EntryTableViewCell {
        cell.innerView.animateHighlight(transform: .init(scaleX: 0.95, y: 0.95), offset: 3.5)
      }
    }
  }

  func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? EntryTableViewCell {
      cell.innerView.animateHighlight(transform: .identity, offset: 4, duration: 0.15)
    }
  }


  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteCellAction = UITableViewRowAction(style: .destructive, title: "Delete") { [unowned self] (action, index) in

      CloudManager.instance.deleteEntry(entries[indexPath.row])
      self.entries.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    return [deleteCellAction]
  }
}

// MARK: Helper methods
private extension JournalViewController {
  /// Scroll the tableview to the bottom of the view.
  func scrollToBottom() {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: self.entries.count - 1, section: 0)
      self.entriesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }

  /// Scroll the tableview to the bottom of the view.
  func scrollToEntry(_ index: Int) {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: index, section: 0)
      self.entriesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
}

extension JournalViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
  }
}
