import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var vyberTableView: UITableView!
    
//    private var currentVyberInformation: [VyberInformation]?

    private var vybers: [Vyber]?

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
        
        vybers = [Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏"), Vyber(name: "BOB", vybe: "🙏")]
        
        vyberTableView.layer.cornerRadius = 5
        
        vyberTableView.delegate = self
        vyberTableView.dataSource = self
        
        vyberTableView.reloadData()
        
        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print("PRESS")
    }
}


