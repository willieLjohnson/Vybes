import UIKit

class ViewController: UIViewController, EmojiViewDelegate {
    
    @IBOutlet weak var emojiView: EmojiView!
    @IBOutlet weak var vyberTableView: TableViewWithCoreAnimations!
    @IBOutlet weak var addVyberButton: UIButton!
    @IBOutlet weak var setEditModeButton: UIButton!
    
    @IBOutlet weak var showVybersButton: UIButton!
    
    //    private var currentVyberInformation: [VyberInformation]?
    
    private var vybers: [Vyber]?
    private var selectedVyberIndex: Int?
    
    @IBOutlet weak var addVyberView: UIView!
    @IBOutlet weak var vyberName: UITextField!
    
    @IBOutlet weak var vyberSegmentedSelector: UISegmentedControl!
    
    //    private func showDataForVyber(at index: Int) {
    //        if (index < vybers.count && index > -1) {
    //            let vyber = vybers[index]
    //            currentVyberInformation = vyber.tableRepresentation
    //        } else {
    //            currentVyberInformation = nil
    //        }
    //
    //        vyberTableView.reloadData()
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        vybers = [Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏")]
        
        vyberTableView.layer.cornerRadius = 5
        showVybersButton.layer.cornerRadius = 5
        
        vyberTableView.delegate = self
        vyberTableView.dataSource = self
        
        vyberTableView.reloadData()
        vyberTableView.isHidden = true
        
        emojiView.isHidden = true
        emojiView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.43)
        emojiView.layer.cornerRadius = 5
        
        addVyberButton.isHidden = true
        setEditModeButton.isHidden = true
        vyberTableView.isEditing = false
        
        emojiView.delegate = self
        
        addVyberView.layer.cornerRadius = 5
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        frost.frame = addVyberView.bounds
        frost.alpha = 0.8
        frost.layer.cornerRadius = 10
        addVyberView.insertSubview(frost, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadVyberTable(with:)), name: .UpdateVyberList, object: nil)
    }
    
    @objc func reloadVyberTable(with notification: Notification) {
        
        if let userInfo = notification.userInfo {
            vybers = userInfo["vybers"] as? [Vyber]
            vyberTableView.reloadData()
        } else {
            print("ERROR: No userinfo from notification")
        }
        
        addVyberButton.isHidden = false
        setEditModeButton.isHidden = false
    }
    
    @IBAction func showVybers(_ sender: UIButton) {
        if vyberTableView.isHidden {
            vyberTableView.isHidden = false
            addVyberButton.isHidden = false
            setEditModeButton.isHidden = false
            
            vyberTableView.move(fromValue: 500, toValue: 0, axis: .y)
            showVybersButton.setTitle("Dismiss", for: .normal)
        } else {
            vyberTableView.isHidden = true
            addVyberButton.isHidden = true
            setEditModeButton.isHidden = true
            
            vyberTableView.move(fromValue: 0, toValue: 500, axis: .y)
            showVybersButton.setTitle("Show Vybers", for: .normal)
        }
    }
    
    @IBAction func addVyber(_ sender: UIButton) {
        addVyberView.isHidden = false
        setEditModeButton.isHidden = true
        addVyberButton.isHidden = true
        emojiView.isHidden = true
    }
    
    @IBAction func confirmAddVyberView(_ sender: UIButton) {
        if vyberName.text != "" {
            addVyberView.isHidden = true
            addVyberButton.isHidden = false
            setEditModeButton.isHidden = false
            
            let newVyber = Vyber(name: vyberName.text!, vybe: vyberSegmentedSelector.titleForSegment(at: vyberSegmentedSelector.selectedSegmentIndex)!, delegate: emojiView)
            
            if vybers != nil {
                vybers?.append(newVyber)
            } else {
                vybers = [newVyber]
            }
            
            vyberName.text = ""
            vyberTableView.reloadData()
        }
    }
    
    @IBAction func cancelAddVyberView(_ sender: UIButton) {
        addVyberView.isHidden = true
        addVyberButton.isHidden = false
        setEditModeButton.isHidden = false
        
        vyberName.text = ""
    }
    
    @IBAction func setEditMode(_ sender: UIButton) {
        vyberTableView.isEditing = !vyberTableView.isEditing
    }
    
    func getSelectedVyberIndex() -> Int? {
        return selectedVyberIndex
    }
    
    func getVyberList() -> [Vyber]? {
        return vybers
    }
    
    func reloadData() {
        vyberTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vybers = vybers else { return 0 }
        
        return vybers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VyberCell
        
        if let vybers = vybers {
            let row = indexPath.row
            
            cell.name!.text = vybers[row].name
            cell.vybe!.text = vybers[row].vybe
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        emojiView.isHidden = false
        addVyberButton.isHidden = true
        setEditModeButton.isHidden = true
        
        selectedVyberIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (vybers?[indexPath.row]) != nil {
                vybers?.remove(at: indexPath.row)
                vyberTableView.reloadData()
            }
        }
    }
    
}


